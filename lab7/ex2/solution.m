clf; close all; clear; clc;

% prepare the folder for the results
mkdir('output');

% load the data
X = importdata('data/cluster_data.mat');

% different distances
strategies = {'single', 'complete', 'average'};
for i = 1 : length(strategies)
    
    % extract the current strategy
    strategy = strategies{i};
    
    % plot the clustering
    clusters = clusterdata(X, 'maxclust', 4, 'linkage', strategy, 'distance', 'euclidean');
    figure;
    centroids = splitapply(@(x) mean(x, 1), X, clusters);
    gscatter(X(:, 1), X(:, 2), clusters, [], [], [], 'off');
    hold on;
    gscatter(centroids(:, 1), centroids(:, 2), zeros(length(centroids), 1), 'k', '.', 50, 'off');
    hold off;
    xlabel('Dimension 1');
    ylabel('Dimension 2');
    title(sprintf('Custering using %s linkage', strategy));
    saveas(gcf, sprintf('output/cluster_%s', strategy), 'png');
    
    % plot the dendrogram
    figure;
    [H, T, outperm] = dendrogram(linkage(pdist(X, 'euclidean'), strategy), size(X, 1));
    title(sprintf('Custering using %s linkage', strategy));
    saveas(gcf, sprintf('output/dendrogram_%s', strategy), 'png');
end
