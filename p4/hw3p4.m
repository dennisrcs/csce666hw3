% Getting data from file
hw3p4_train = load('hw3p4_train.mat');
hw3p4_test = load('hw3p4_test.mat');

% Retriving training
train = hw3p4_train.x1;
clab_train = hw3p4_train.clab1;

% Retriving test data
test = hw3p4_test.x2;

% preprocessing
train = preprocess(train);
test = preprocess(test);
data = [train; test];
data = normc(data);

test_size = length(test);
train_size = length(train);
train = data(1:train_size,:);
test = data(train_size+1:end,:);

% Selecting the following features from the data
indices = [6,14,25,15,21,27,20,24,29,28];
train = train(:,indices);
test = test(:,indices);

uclab = [];
for i = 1:test_size
    % Predicting test data class
    class_predicted = knn_predict(test(i, :), train, clab_train, 1);
    uclab = [uclab; class_predicted];
end