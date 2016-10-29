function processed_data = preprocess(data)
%PREPROCESS Summary of this function goes here
%   Detailed explanation goes here
    
    num_features = size(data,2);
    num_examples = size(data,1);
    
    for i = 1:num_features
        aux = data(:,i);
        aux = aux(aux ~= -1);
        avg_val = mean(aux);
        for j = 1:num_examples
            if data(j,i) == -1
                data(j,i) = avg_val;
            end
        end
    end

    processed_data = data;
end

