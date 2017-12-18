clf; close all;
clear;

% prepare the folder for the results
mkdir('output');

% load the LVQ1 algorithm from exercise 1
addpath(genpath('../ex1'));

% load the raw data
A = importdata('data/data_lvq_A.mat');
B = importdata('data/data_lvq_B.mat');

% compute the labels
X = [A; B];
y = [ones(length(A), 1); ones(length(B), 1) * 2];

% split the dataset in 10 folds
n = 10;
folds = n_fold(length(y), n);

% compute the test error for each split
errors = zeros(n, 1);
for i = 1 : n

    % mask for the train dataset
    current_fold = logical(folds(:, i));
    
    % train dataset
    X_train = X(current_fold', :);
    y_train = y(current_fold);
    
    % validation dataset
    X_val = X(~current_fold, :);
    y_val = y(~current_fold);
    
    % train LVQ1
    [prototypes, prototypes_classes, ~] = lvq1_train(X_train, y_train, [2; 1], 0.01);
    
    % validation
    y_predicted = lvq1_classify(X_val, prototypes, prototypes_classes);
    errors(i) = mean(y_predicted ~= y_val);
end

% average test error
average_error = mean(errors);

% plot
figure;
bar(errors);
title('Test Error using 10-Fold Cross Validation');
xlabel('Fold Index');
ylabel('Test Error');
hold on;
plot(xlim, [average_error average_error], 'r');
hold off;
saveas(gcf, 'output/errors_n_fold', 'png');
