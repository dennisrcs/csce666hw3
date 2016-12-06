% getting data from file
hw3p1_data = load('hw3p1_data.mat');
width = hw3p1_data.rows;
height = hw3p1_data.cols;
data = hw3p1_data.x;

figure;
for i = 1:size(data,1)
    faculty = reshape(data(i,:), [width, height]);
    subplot(6, 7, i);
    imagesc(faculty);
    title(num2str(i));
    %set(gca,'visible','off');
    colormap gray;
end

% part a
avg_face = mean(data);
avg_face_reshaped = reshape(avg_face, [width, height]);
figure;
imagesc(avg_face_reshaped);
colormap gray;

% doing snapshot pca
cent_data = data - avg_face;
[u, P] = snapshot_pca(cent_data);
efaces = cent_data' * u; efaces = efaces';

% projecting the data onto first 6 components
efaces_reduced = efaces(1:6,:);
proj_data = cent_data*efaces_reduced'; proj_data = proj_data';

labels = strings(1,42);
for i = 1:42
    labels(i) = num2str(i);
end

% part c
figure;
subplot(2,3,1);
scatter(proj_data(1,:), proj_data(2,:), 'b.');
text(proj_data(1,:), proj_data(2,:), cellstr(labels), 'FontSize', 12);
xlabel('PC1');ylabel('PC2');

subplot(2,3,2);
scatter(proj_data(2,:), proj_data(3,:), 'b.');
text(proj_data(2,:), proj_data(3,:), cellstr(labels), 'FontSize', 12);
xlabel('PC2');ylabel('PC3');

subplot(2,3,3);
scatter(proj_data(3,:), proj_data(4,:), 'b.');
text(proj_data(3,:), proj_data(4,:), cellstr(labels), 'FontSize', 12);
xlabel('PC3');ylabel('PC4');

subplot(2,3,4);
scatter(proj_data(4,:), proj_data(5,:), 'b.');
text(proj_data(4,:), proj_data(5,:), cellstr(labels), 'FontSize', 12);
xlabel('PC4');ylabel('PC5');

subplot(2,3,5);
scatter(proj_data(5,:), proj_data(6,:), 'b.');
text(proj_data(5,:), proj_data(6,:), cellstr(labels), 'FontSize', 12);
xlabel('PC5');ylabel('PC6');

ind1 = [1, 3, 4, 5, 7, 9, 13, 18, 19, 23, 27, 28, 29, 31, 36, 39, 40, 41, 42];
ind2 = [2, 6, 8, 10, 11, 12, 14, 15, 16, 17, 20, 21, 22, 24, 25, 26, 30, 32, 33, 34, 35, 37, 38];

cluster1 = data(ind1,:);
cluster2 = data(ind2,:);

figure;
for i = 1:size(ind1,2)
    faculty = reshape(cluster1(i,:), [width, height]);
    subplot(4, 5, i);
    imagesc(faculty);
    set(gca,'visible','off');
    colormap gray;
end

figure;
for i = 1:size(ind2,2)
    faculty = reshape(cluster2(i,:), [width, height]);
    subplot(4, 6, i);
    imagesc(faculty);
    set(gca,'visible','off');
    colormap gray;
end

figure;
scatter(proj_data(1,ind1), proj_data(2,ind1), 'b.');
hold on;
scatter(proj_data(1,ind2), proj_data(2,ind2), 'r.');
xlabel('PC1');ylabel('PC2');