clf; close all;
clear;

% prepare the folder for the results
mkdir('output');

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
labels = arrayfun(@(y) iff(y == 1, "A", "B"), y);

% scatter plot of the dataset
gscatter(X(:, 1), X(:, 2), labels, colors, mrk);
title('Dataset');
xlabel('Feature 1');
ylabel('Feature 2');
saveas(gcf, 'output/dataset', 'png');

% try different combination of #prototypes
q6 = figure;
n_prototypes = [1,1; 1,2; 2,1; 2,2];
for i = 1 : size(n_prototypes, 1)
    
    % train the LVQ1 classifier
    [prototypes, prototypes_classes, errors] = lvq1_train(X, y, n_prototypes(i, :)', 0.01);
    
    % use the number of prototypes to generate decent names
    n_prototypes_title = mat2str(n_prototypes(i, :));
    suffix = join(string(n_prototypes(i, :)), '_');
    
    % plot the training error
    figure;
    plot(errors);
    title(sprintf('Training Error using %s prototypes', n_prototypes_title));
    xlabel('Epoch');
    ylabel('Training Error = #errors / #examples');
    saveas(gcf, sprintf('output/training_error_%s', suffix), 'png');
    
    % plot for question 6
    figure(q6);
    dim = ceil(sqrt(size(n_prototypes, 1)));
    subplot(dim, dim, i);
    h6 = gscatter(prototypes(:, 1), prototypes(:, 2), prototypes_classes, colors, mrk, 8, 'off');
    for n = 1 : length(h6)
        set(h6(n), 'MarkerFaceColor', colors(n, :));
    end
    hold on;
    y_lvq1 = lvq1_classify(X, prototypes, prototypes_classes);
    gscatter(X(:, 1), X(:, 2), y_lvq1, colors_2, mrk, 4);
    hold off;
    title(sprintf('Classification using %s prototypes', n_prototypes_title));
    xlabel('Feature 1');
    ylabel('Feature 2');

    % EXTRA: some plots for the decision boundary
    grid_points = make_grid(floor(min(X)), ceil(max(X)), [100, 100]);
    grid_labels = lvq1_classify(grid_points, prototypes, prototypes_classes);
    plot_result(grid_points, grid_labels, X, labels, prototypes, prototypes_classes, n_prototypes(i, :), mrk, colors, colors_1, colors_2);
    saveas(gcf, sprintf('output/results_%s', suffix), 'png');
end

% save plot for question 6
saveas(q6, 'output/comparison', 'png');
