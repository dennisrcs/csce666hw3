% loading image
fullimg = imread('hw3p3_im.jpg');

% initializing
width = size(fullimg, 1);
height = size(fullimg, 2);
img = reshape(fullimg, [width*height, 3]);
img_size = size(img, 1);
clusters = zeros(img_size, 1);

figure;
image_name = 'hw3p3c';
% k-means
for k = 1:10
    % generating centroids
    cent = zeros(k, 3);
    num_px_set = floor(img_size / k);
    for i = 1:k
        pixels_set = img(1+(i-1)*num_px_set:i*num_px_set,:);
        cent(i,:) = mean(pixels_set);
    end
    
    % assigning random clusters
    for i = 1:img_size
        clusters(i) = randi(k);
    end
    
    old_cent = cent + 1;
    while ~isequal(cent, old_cent)
        old_cent = cent;
        
        % Reassign each example to the cluster with the nearest mean
        distances = zeros(img_size, k+1);
        for j = 1:k
            distances(:,j) = sqrt(sum((cent(j,:)-double(img)).^2,2));
        end
        distances(:,k+1) = Inf(img_size,1);
        [ignore, clusters] = min(distances,[],2);
        
        % compute the sample mean of each cluster
        for j = 1:k
            samples = img(clusters == j, :);
            cent(j,:) = mean(samples);
        end
    end
    
    new_image = zeros(width*height, 3);
    % assigning random clusters
    for i = 1:img_size
        new_image(i,:) = cent(clusters(i),:);
    end
    
    new_image = reshape(new_image, [width, height, 3]);
    imwrite(uint8(new_image), strcat(image_name,num2str(k),'.jpg'));
    subplot(5,2,k);
    imagesc(uint8(new_image));
    title(strcat('K=',num2str(k)));
end