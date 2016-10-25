function [u, P, D] = snapshot_pca(data)
%SNAPSHOT_PCA Computes the snapshot PCA

    P = size(data, 1);
    D = size(data, 2);
    R = zeros(P);
    
    for i = 1:P
        for j = 1:P
            R(i,j) = (1 / P) * data(i,:) * transpose(data(j,:));
        end
    end

    R_cov = cov(R);
    [u, s, v] = svd(R_cov);
end

