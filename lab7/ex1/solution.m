clf; close all; clear; clc;

% prepare the folder for the results
mkdir('output');

% load the data
X = importdata('data/cluster_data.mat');

% plots
figure;
thresholds = [0.05, 0.1, 0.15, 0.2, 0.25]';
errors = zeros(length(thresholds), 1);
for t = 1 : length(thresholds)
    threshold = thresholds(t);
    fprintf('Process threshold = %.2f... ', threshold);
    
    % plot the dataset / clusters
    subplot(3, 2, t);
    plot_lines(X, threshold);
    hold on;
    scatter(X(:, 1), X(:, 2), 3, 'b');
    hold off;
    title(sprintf('Threashold = %.2f', threshold));
    
    % measure the error
    clusters = cluster_by_distance(X, threshold);
    errors(t) = normalized_quantization_error(X, clusters);
    fprintf('(normalized) quantization error = %f\n', errors(t));
end
saveas(gcf, 'output/thresholds', 'png');

% plot the clusters for the optimal threshold
[~, optimal_threshold_index] = min(errors);
optimal_threshold = thresholds(optimal_threshold_index);
clusters = cluster_by_distance(X, optimal_threshold);
figure;
plot_lines(X, optimal_threshold);
hold on;
gscatter(X(:, 1), X(:, 2), clusters);
hold off;
title(sprintf('Clustering for the optimal threshold = %.2f', optimal_threshold));
xlabel('Dimension 1');
ylabel('Dimension 2');
saveas(gcf, 'output/optimal_clustering', 'png');
