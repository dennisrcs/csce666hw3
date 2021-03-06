hw3p4_train = load('hw3p4_train.mat');
hw3p4_test = load('hw3p4_test.mat');

% Retriving training
train_data = hw3p4_train.x1;
clab_train_data = hw3p4_train.clab1;

% Retriving test data
test_data = hw3p4_test.x2;
clab_test = hw3p4_test.clab2;

train_data = preprocess(train_data);
indices = find_subset_sfs(train_data, clab_train_data, 10);
train_data = train_data(:,indices);
test_data = test_data(:,indices);

disp('Testing for features:');
disp(indices);

% Initializing
it_num = 30;
ks = [1, 2, 5, 20, 50, 100, 200];
knn_accs = zeros(it_num, size(ks, 2));
quad_accuracy = zeros(it_num, 1);

for it = 1:it_num

    % Splitting the data
    [train, validation, clab_train, clab_validation] = split_data(train_data, clab_train_data);

    % Retriving training and test data
    train_size = size(train, 1);
    validation_size = size(validation, 1);

    % Getting data per class
    train_1 = get_class_data(train, clab_train, 1);
    train_2 = get_class_data(train, clab_train, 2);
    train_3 = get_class_data(train, clab_train, 3);

    % Calculating priors
    prior1 = size(train_1, 1)/train_size;
    prior2 = size(train_2, 1)/train_size;
    prior3 = size(train_3, 1)/train_size;

    % Quadratic classifier performance
    quad_corrects = 0;
    for i = 1:validation_size
        % Computing gi
        g1 = quadratic_classifier(validation(i, :), train_1, prior1);
        g2 = quadratic_classifier(validation(i, :), train_2, prior2);
        g3 = quadratic_classifier(validation(i, :), train_3, prior3);

        % Checking if the class predicted matches the original class label
        [~, class_predicted] = max([g1, g2, g3]);
        if class_predicted == clab_validation(i)
            quad_corrects = quad_corrects + 1;
        end
    end

    quad_accuracy(it) = quad_corrects/validation_size;

    % knn experimentation
    for k = 1:size(ks, 2)
        knn_corrects = 0;
        for i = 1:validation_size
            % Predicting test data class
            class_predicted = knn_predict(validation(i, :), train, clab_train, ks(k));

            if class_predicted == clab_validation(i)
                knn_corrects = knn_corrects + 1;
            end
        end
        knn_accs(it,k) = knn_corrects/validation_size;
    end
end

disp(strcat('quad_accuracy: ', num2str(mean(quad_accuracy)), ', std:', num2str(std(quad_accuracy))));
for k = 1:size(ks, 2)
    disp(strcat('knn_accs k=', num2str(ks(k)), ':', num2str(mean(knn_accs(:, k))), ', std:', num2str(std(knn_accs(:, k)))));
end