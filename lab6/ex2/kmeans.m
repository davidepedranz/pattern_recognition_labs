function [clusters, prototypes, prototypes_history] = kmeans(X, initialization)
    
    % extract the number of examples in the dataset
    [n_examples, n_dimensions] = size(X);
    
    % initialize the prototypes
    assert(size(initialization, 1) >= 1);
    assert(size(initialization, 2) == n_dimensions);
    prototypes = initialization;
        
    % initialize the labels
    old_clusters = zeros(n_examples, 1);
    clusters = ones(n_examples, 1);

    % loop until the algorithm converges
    epoch = 0;
    while ~isequal(old_clusters, clusters)
        epoch = epoch + 1;
                
        % store the old clusters
        old_clusters = clusters;
        
        % store the history
        prototypes_history(:, :, epoch) = prototypes; %#ok<AGROW>
        
        % compute the distances
        % NB: we use squaredeuclidean just for performances reasons
        % since we are just interested in the distances ranking
        % this will give the same results as the normal euclidian distance
        distances = pdist2(X, prototypes, 'squaredeuclidean');
        
        % assign points to the clusters
        [~, clusters] = min(distances, [], 2);
        
        % recompute the centers of the cluster
        prototypes = splitapply(@(x) mean(x, 1), X, clusters);
    end
end
