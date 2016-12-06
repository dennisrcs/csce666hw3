clear;clc;
% loading files
us_data = load('us_city_distance.mat');
world_distance = load('world_city_distance.mat');

% getting data from us_city_distance file
us_d = us_data.d;
us_names = us_data.names;
num_nodes = length(us_d);

% creating H matrix
us_H = eye(num_nodes) - (1/num_nodes)*ones(num_nodes, 1)*ones(1,num_nodes);
us_S = us_d.^2;

% computing tau d_g
us_T_DG = -us_H*us_S*us_H/2;
[eigvec, full_eigval] = eigs(us_T_DG, 10, 'LR');

% plotting eigenvalues
eigval = diag(full_eigval);
figure;
subplot(1, 2, 1);
plot(1:1:size(eigval, 1), eigval, 'LineWidth', 1.5);
xlabel('Eigenvalue index');
ylabel('Eigenvalues');
xlim([1 size(eigval, 1)])

cum_eigval = cumsum(eigval);
subplot(1, 2, 2);
plot(1:1:size(eigval, 1), cum_eigval/cum_eigval(length(cum_eigval)), 'LineWidth', 1.5);
xlabel('Eigenvalue index');
ylabel('Normalized Cumulative Eigenvalues');
xlim([1 size(eigval, 1)])
d = 3;
y = zeros(num_nodes, d);
d_eigvec = eigvec(:,1:d);

% creating the embedding representation
for i = 1:num_nodes
    for j = 1:d
        y(i,j) = sqrt(eigval(j)) * eigvec(i,j);
    end
end

% 2D scatter plots
figure, scatter(y(:,1), y(:,2));
text(y(:,1), y(:,2), us_names);
xlabel('Y1');ylabel('Y2');

indices = [6, 9, 26, 41, 45, 55, 66, 67, 79, 80, 93, 95, 107, 115, 125, 130];
for i = 1:size(us_names, 1)
    if ismember(i, indices)
        some_names(i,:) = us_names(i,:);
    else
        some_names(i,:) = ' ';
    end
end

% 3D scatter plot
figure, scatter3(y(:,1), y(:,2), y(:,3));
text(y(:,1), y(:,2), y(:,3), some_names);
xlabel('Y1');ylabel('Y2');zlabel('Y3');