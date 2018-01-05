clf; close all;
clear;

% prepare the folder for the results
mkdir('output');

% load the n_fold algorithm from exercise 2
addpath(genpath('../ex2'));

% some constants used for the plots
mrk = '^o';
colors = [0 0 1; 1 0 0];
colors_1 = [0.3 0.3 1; 1 0.3 0.3];
colors_2 = [0.7 0.7 1; 1 0.7 0.7];

% load the raw data
A = importdata('data/data_lvq_A.mat');
B = importdata('data/data_lvq_B.mat');

% compute the labels
X = [A; B];
y = [ones(length(A), 1); ones(length(B), 1) * 2];

% train RLVQ
n_prototypes = [2; 1];
[prototypes, prototypes_classes, relevances, relevances_history, validation_errors] = rlvq_train(X, y, n_prototypes, 0.01, 0.001);

% plot the feature space
figure;
fs = gscatter(prototypes(:, 1), prototypes(:, 2), prototypes_classes, colors, mrk, 16, 'off');
for n = 1 : length(fs)
    set(fs(n), 'MarkerFaceColor', colors(n, :));
end
hold on;
gscatter(X(:, 1), X(:, 2), y, colors_1, mrk);
hold off;
title('Dataset');
xlabel('Feature 1');
ylabel('Feature 2');
saveas(gcf, 'output/prototypes', 'png');

% plot the training errors
figure;
subplot(2, 1, 1);
plot(validation_errors);
title('Training Error');
xlabel('Epoch');
ylabel('Training Error');

% plot the changes in the relevances
subplot(2, 1, 2);
plot(relevances_history);
title('Features Relevances');
xlabel('Epoch');
ylabel('Relevance');
legend({'Feature 1', 'Feature 2'});

% save the plot
saveas(gcf, 'output/validation_errors_and_relevances', 'png');

% cross validation

% split the dataset in 10 folds
n = 10;
folds = n_fold(length(y), n);

% compute the test error for each split
validation_errors = zeros(n, 1);
for i = 1 : n

    % mask for the train dataset
    current_fold = logical(folds(:, i));
    
    % train dataset
    X_train = X(current_fold', :);
    y_train = y(current_fold);
    
    % validation dataset
    X_val = X(~current_fold, :);
    y_val = y(~current_fold);
    
    % train RLVQ
    [prototypes, prototypes_classes, relevances, relevances_history, ~] = rlvq_train(X_train, y_train, n_prototypes, 0.01, 0.001);
    
    % validation
    y_predicted = rlvq_classify(X_val, prototypes, prototypes_classes, relevances);
    validation_errors(i) = mean(y_predicted ~= y_val);
end

% average test error
average_error = mean(validation_errors);

% plot
figure;
bar(validation_errors);
title('RLVQ Test Error using 10-Fold Cross Validation');
xlabel('Fold Index');
ylabel('Test Error');
hold on;
plot(xlim, [average_error average_error], 'r');
hold off;
saveas(gcf, 'output/rlvq_errors_n_fold', 'png');


% [EXTRA]: plot the separation boundary
addpath(genpath('../ex1'));
grid_points = make_grid(floor(min(X)), ceil(max(X)), [100, 100]);
grid_labels = rlvq_classify(grid_points, prototypes, prototypes_classes, relevances);
plot_result(grid_points, grid_labels, X, y, prototypes, prototypes_classes, n_prototypes, mrk, colors, colors_1, colors_2);
saveas(gcf, 'output/classification_2_1', 'png');
