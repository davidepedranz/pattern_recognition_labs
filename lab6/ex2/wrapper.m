clf; close all; clear; clc;

% prepare the folder for the results
mkdir('output');

% load the dataset
X = importdata('data/checkerboard.mat');

% run k-mean
initialization = importdata('data/clusterCentroids.mat');
[~, prototypes_kmeans, ~] = kmeans(X, initialization);
figure;
plotResult(X, prototypes_kmeans);
title('k-means Clustering');
saveas(gcf, 'output/kmeans', 'png');

% run batch neural gas
figure;
epochs = [20, 100, 200, 500];
for i = 1 : length(epochs)
    e = epochs(i);
    prototypes_ng = batchNG(X, 100, e, 1, 2, false);
    subplot(2, 2, i);
    plotResult(X, prototypes_ng);
    title(sprintf('Batch Neural Gas Clustering after %d epochs', e));
    drawnow;
end
saveas(gcf, 'output/ng', 'png');
