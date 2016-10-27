% loading image
fullimg = imread('hw3p3_im.jpg');

% initializing
width = size(fullimg, 1);
height = size(fullimg, 2);
img = reshape(fullimg, [width*height, 3]);
img_size = size(img, 1);
clusters = zeros(img_size, 1);

res_ind = 1:2:img_size;
img = img(res_ind,:);
img_size = length(img);
sse = zeros(1,10);

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

    new_image = zeros(img_size, 3);
    % assigning random clusters
    for i = 1:img_size
        new_image(i,:) = cent(clusters(i),:);
    end

    % computing sum squared error
    sse(k) = sum(sum((new_image-double(img)).^2,2));
end

figure, semilogy(sse, 'LineWidth', 2);
axis([1 10 4*10^7 1.5*10^9]);
xlabel('K'); ylabel('Sum Squared Error');