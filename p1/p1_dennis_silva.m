% getting data from file
hw3p1_data = load('hw3p1_data.mat');
width = hw3p1_data.rows;
height = hw3p1_data.cols;
data = hw3p1_data.x;

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

figure;
for i = 1:P
    if i <= 6
        reshaped_img = reshape(efaces(i,:), [width, height]);
        subplot(2,3,i);
        imagesc(reshaped_img);
        colormap gray;
        title(strcat('eigenface #', num2str(i)));
    end
end

% projecting the data onto first 6 components
efaces_reduced = efaces(1:6,:);
proj_data = cent_data*efaces_reduced'; proj_data = proj_data';

% part c
figure;
subplot(2,3,1);
scatter(proj_data(1,:), proj_data(2,:));
xlabel('PC1');ylabel('PC2');

subplot(2,3,2);
scatter(proj_data(2,:), proj_data(3,:));
xlabel('PC2');ylabel('PC3');

subplot(2,3,3);
scatter(proj_data(3,:), proj_data(4,:));
xlabel('PC3');ylabel('PC4');

subplot(2,3,4);
scatter(proj_data(4,:), proj_data(5,:));
xlabel('PC4');ylabel('PC5');

subplot(2,3,5);
scatter(proj_data(5,:), proj_data(6,:));
xlabel('PC5');ylabel('PC6');