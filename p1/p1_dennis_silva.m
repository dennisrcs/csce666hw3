% getting data from file
hw3p1_data = load('hw3p1_data.mat');
width = hw3p1_data.rows;
height = hw3p1_data.cols;
data = hw3p1_data.x;

% part a
avg_face = mean(data);
avg_face_reshaped = reshape(avg_face, [width, height]);
imagesc(avg_face_reshaped);

% part b
cent_data = data - avg_face;
[u, P, D] = snapshot_pca(cent_data);

efaces = zeros(P, D);
for i = 1:P
    efaces(:,:) = efaces(:,:) + u(:,i)*data(i,:);
end

figure;
for i = 1:P
    if i <= 6
        reshaped_img = reshape(efaces(i,:), [width, height]);
        subplot(2,3,i);
        imagesc(reshaped_img);
        title(strcat('eigenface #', num2str(i)));
    end
end

% part c
figure;
subplot(3,5,1);
scatter(efaces(1,:), efaces(2,:));
title('PC1 x PC2')

subplot(3,5,2);
scatter(efaces(1,:), efaces(3,:));
title('PC1 x PC3')

subplot(3,5,3);
scatter(efaces(1,:), efaces(4,:));
title('PC1 x PC4')

subplot(3,5,4);
scatter(efaces(1,:), efaces(5,:));
title('PC1 x PC5');

subplot(3,5,5);
scatter(efaces(1,:), efaces(6,:));
title('PC1 x PC6');

subplot(3,5,6);
scatter(efaces(2,:), efaces(3,:));
title('PC2 x PC3');

subplot(3,5,7);
scatter(efaces(2,:), efaces(4,:));
title('PC2 x PC4');

subplot(3,5,8);
scatter(efaces(2,:), efaces(5,:));
title('PC2 x PC5');

subplot(3,5,9);
scatter(efaces(2,:), efaces(6,:));
title('PC2 x PC6');

subplot(3,5,10);
scatter(efaces(3,:), efaces(4,:));
title('PC3 x PC4');

subplot(3,5,11);
scatter(efaces(3,:), efaces(5,:));
title('PC3 x PC5');

subplot(3,5,12);
scatter(efaces(3,:), efaces(6,:));
title('PC3 x PC6');

subplot(3,5,13);
scatter(efaces(4,:), efaces(5,:));
title('PC4 x PC5');

subplot(3,5,14);
scatter(efaces(4,:), efaces(6,:));
title('PC4 x PC6');

subplot(3,5,15);
scatter(efaces(5,:), efaces(6,:));
title('PC5 x PC6');