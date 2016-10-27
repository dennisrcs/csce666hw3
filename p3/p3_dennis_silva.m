% loading image
img = imread('hw3p3_im.jpg');

width = size(img, 1);
height = size(img, 2);
resh_img = reshape(img, [width*height, 3]);
img_size = size(resh_img, 1);
clusters = zeros(img_size, 1);

ed = @(x,y) sum((x-y).^2).^0.5;

% k-means
for k = 1:10
    % generating random centroids
    cent = zeros(k, 3);
    for i = 1:k
        cent(i,:) = [randi(255) randi(255) randi(255)];
    end
    
    % assigning random clusters
    for i = 1:img_size
        clusters(i) = randi(k);
    end
    
    old_cent = cent + 1;
    while ~isequal(cent, old_cent)
        % compute the sample mean of each cluster
        old_cent = cent;
        for j = 1:k
            samples = resh_img(clusters == j, :);
            cent(j,:) = mean(samples);
        end
        
        % Reassign each example to the cluster with the nearest mean
        for j = 1:img_size
            pixel = resh_img(j,:);
            pixel_d = zeros(k,1);
            for l = 1:k
                pixel_d(l) = ed(double(pixel(:))', cent(l,:));
            end
            [ignore, id] = min(pixel_d);
            clusters(j) = id;
        end
    end
    
    new_image = zeros(width*height, 3);
    % assigning random clusters
    for i = 1:img_size
        new_image(i,:) = cent(clusters(i),:);
    end
    
    new_image = reshape(new_image, [width, height, 3]);
    figure, imagesc(uint8(new_image));
end