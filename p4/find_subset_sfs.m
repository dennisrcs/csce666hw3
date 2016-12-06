function indices = find_subset_sfs(data, clab, final_num_features)
%FIND_SUBSET Summary of this function goes here
%   Detailed explanation goes here

    indices = [];
    subset = [];
    num_feat = size(data,2);
    
    it_num = 10;
    
    while length(indices) < final_num_features
        fitness = zeros(num_feat, 1);
        for f = 1:num_feat
            if ~ismember(f, indices)
                curr_subset = [subset data(:,f)];

                corrects = 0;
                for it = 1:it_num
                    [train, validation, clab_train, clab_validation] = split_data(curr_subset, clab);

                    for i = 1:size(validation,1)
                        % Predicting test data class
                        class_predicted = knn_predict(validation(i, :), train, clab_train, 3);

                        if class_predicted == clab_validation(i)
                            corrects = corrects + 1;
                        end
                    end
                end
                fitness(f) = (corrects/size(validation,1))/it_num;
            end        
        end

        [ignore, idx] = max(fitness);
        subset = [subset data(:,idx)];
        indices = [indices idx];
        
    end
end