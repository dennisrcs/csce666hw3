% getting data from file
hw3p1_data = load('hw3p1_data.mat');
width = hw3p1_data.rows;
height = hw3p1_data.cols;
data = hw3p1_data.x;

% part a
avg_face = mean(data);
avg_face_reshaped = reshape(avg_face, [width, height]);
imshow(avg_face_reshaped, [0 255]);

% part b
cent_data = data - avg_face;
[u, P, D] = snapshot_pca(cent_data);

efaces = zeros(P, D);
for i = 1:P
    efaces(:,:) = efaces(:,:) + u(:,i)*data(i,:);
end

for i = 1:P
    minx = min(efaces(i,:));
    maxx = max(efaces(i,:));
    
    face = (efaces(i,:) - minx)/(maxx-minx);
    
    ximg = reshape(face, [width, height]);
    %imshow(ximg);
end

% part c
figure, scatter(efaces(1,:), efaces(2,:));