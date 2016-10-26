function [u, P] = snapshot_pca(data)
%SNAPSHOT_PCA Computes the snapshot PCA

    P = size(data, 1);
    R = zeros(P);
    
    for i = 1:P
        for j = 1:P
            R(i,j) = (1 / P-1) * data(i,:) * transpose(data(j,:));
        end
    end
    
    [u, s, v] = svd(R);
end