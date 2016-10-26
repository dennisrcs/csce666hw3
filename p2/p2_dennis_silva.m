% loading files
us_data = load('us_city_distance.mat');
world_distance = load('world_city_distance.mat');

% part a

% getting data from us_city_distance file
us_d = us_data.d;
us_names = us_data.names;
num_nodes = length(us_d);

% creating graph
k = 10;
DG = Inf(num_nodes);

for i = 1:num_nodes
    DG(i,i) = 0;
end

for i = 1:num_nodes
    % getting k nearest nodes
    [ds, ids] = sort(us_d(i,:));
    k_d = ds(2:k+1);
    k_id = ids(2:k+1);
    
    % adding edge to graph
    for j = 1:k
        if i < k_id(j)
            % Twice since the matrix is symmetric
            DG(i,k_id(j)) = k_d(j);
            DG(k_id(j),i) = k_d(j);
        end
    end
end

% building all shortest path graph (Floyd-Marshall algorithm)
for k = 1:num_nodes
    for i = 1:num_nodes
        for j = 1:num_nodes
            % Distances from i to j directly and passing through k
            d_ij = DG(i,j);
            d_ikj = DG(i,k) + DG(k,j);
            new_d = min(d_ij, d_ikj);
            
            % Updating edges
            DG(i,j) = new_d;
        end
    end
end

% creating H matrix
H = eye(num_nodes) - (1/num_nodes)*ones(num_nodes, 1)*ones(1,num_nodes);
S = DG.^2;

% computing tau d_g
T_DG = -H*S*H/2;
[eigvec, full_eigval, ignore] = svd(cov(T_DG));

eigval = diag(full_eigval);
figure;
subplot(1, 2, 1);
semilogx(1:1:size(S, 1), eigval, 'LineWidth', 1.5);
xlabel('Eigenvalue index');
ylabel('Eigenvalues');

cum_eigval = cumsum(eigval);
subplot(1, 2, 2);
semilogx(1:1:size(S, 1), cum_eigval/cum_eigval(length(cum_eigval)), 'LineWidth', 1.5);
xlabel('Eigenvalue index');
ylabel('Normalized Cumulative Eigenvalues');

d = 3;
y = zeros(num_nodes, d);
d_eigvec = eigvec(:,1:d);

for i = 1:num_nodes
    for j = 1:d
        y(i,j) = sqrt(eigval(j)) * eigvec(i,j);
    end
end

figure, scatter(y(:,1), y(:,2))