function indices = find_subset(data, clab)
%FIND_SUBSET Summary of this function goes here
%   Detailed explanation goes here

    indices = [];
    subset = [];
    num_feat = size(data,2);
    
    while length(indices) <= 10
        fitness = zeros(num_feat, 1);
        for f = 1:num_feat
            if ~ismember(f, indices)
                curr_subset = [subset data(:,f)];

                [train, validation, clab_train, clab_validation] = split_data(curr_subset, clab);

                corrects = 0;
                for i = 1:size(validation,1)
                    % Predicting test data class
                    class_predicted = knn_predict(validation(i, :), train, clab_train, 2);

                    if class_predicted == clab_validation(i)
                        corrects = corrects + 1;
                    end
                end
                fitness(f) = corrects/size(validation,1);
            end        
        end

        [ignore, idx] = max(fitness);
        indices = [indices idx];
    end
end

