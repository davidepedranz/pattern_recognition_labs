clf; close all;
clear;

% load the raw data
A = importdata('data/data_lvq_A.mat');
B = importdata('data/data_lvq_B.mat');

% compute the labels
X = [A; B];
y = [ones(length(A), 1); ones(length(B), 1) * 2];
labels = arrayfun(@(y) iff(y == 1, "A", "B"), y);

% scatter plot of the dataset
gscatter(X(:, 1), X(:, 2), labels, 'br', 'xo');
xlabel('Feature 1');
ylabel('Feature 2');
title('Dataset');
saveas(gcf, 'dataset', 'png');

% train the LVQ classifier
[prototypes, prototypes_classes, errors] = lvq_train(X, y, [2; 1], 0.01);

% plot the prototypes
hold on;
gscatter(prototypes(:, 1), prototypes(:, 2), prototypes_classes, 'cy', '*.', 20, 'off');
hold off;

% plot the training error
figure;
plot(errors);
title('Training Error');
xlabel('Epoch');
ylabel('Training Error = #errors / #examples');
