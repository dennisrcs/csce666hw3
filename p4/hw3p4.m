% Getting data from file
hw3p4_train = load('hw3p4_train.mat');
hw3p4_test = load('hw3p4_test.mat');

% Retriving training
train = hw3p4_train.x1;
clab_train = hw3p4_train.clab1;

% Retriving test data
test = hw3p4_test.x2;
clab_test = hw3p4_test.clab2;

% preprocessing
train = preprocess(train);
test = preprocess(test);

% Selecting the following features from the data
%indices = [14, 29, 6, 15, 1, 3, 25, 20, 17, 18, 28];
indices = [29, 6, 44, 43, 15, 1, 3, 17, 7, 28, 20];
train = train(:,indices);
test = test(:,indices);

test_size = length(test);
uclab = [];
knn_corrects = 0;
for i = 1:test_size
    % Predicting test data class
    class_predicted = knn_predict(test(i, :), train, clab_train, 1);

    if class_predicted == clab_test(i)
        knn_corrects = knn_corrects + 1;
    end
    uclab = [uclab; class_predicted];
end

knn_corrects/test_size