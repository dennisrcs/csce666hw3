clear;clc;
% loading files
world_distance = load('world_city_distance.mat');

% getting data from us_city_distance file
world_d = world_distance.d;
world_names = world_distance.names;
world_num_nodes = length(world_d);

% creating H matrix
world_H = eye(world_num_nodes) - (1/world_num_nodes)*ones(world_num_nodes, 1)*ones(1,world_num_nodes);
world_S = world_d.^2;

% computing tau d_g
world_T_DG = -world_H*world_S*world_H/2;
[eigvec, full_eigval, ignore] = svd(world_T_DG);

eigval = diag(full_eigval);
figure;
subplot(1, 2, 1);
semilogx(1:1:size(world_S, 1), eigval, 'LineWidth', 1.5);
xlabel('Eigenvalue index');
ylabel('Eigenvalues');

cum_eigval = cumsum(eigval);
subplot(1, 2, 2);
semilogx(1:1:size(world_S, 1), cum_eigval/cum_eigval(length(cum_eigval)), 'LineWidth', 1.5);
xlabel('Eigenvalue index');
ylabel('Normalized Cumulative Eigenvalues');

d = 3;
y = zeros(world_num_nodes, d);
d_eigvec = eigvec(:,1:d);

for i = 1:world_num_nodes
    for j = 1:d
        y(i,j) = sqrt(eigval(j)) * eigvec(i,j);
    end
end

% 2D scatter plots
figure, scatter(y(:,1), y(:,2));
text(y(:,1), y(:,2), world_names);
xlabel('Y1');ylabel('Y2');

figure, scatter(y(:,1), y(:,3));
text(y(:,1), y(:,3), world_names);
xlabel('Y1');ylabel('Y3');

figure, scatter(y(:,2), y(:,3));
text(y(:,2), y(:,3), world_names);
xlabel('Y2');ylabel('Y3');

% 3D scatter plot
figure, scatter3(y(:,1), y(:,2), y(:,3));
text(y(:,1), y(:,2), y(:,3), world_names);
xlabel('Y1');ylabel('Y2');zlabel('Y3');