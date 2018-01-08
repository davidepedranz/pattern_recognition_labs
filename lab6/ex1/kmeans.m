function [clusters, prototypes, prototypes_history] = kmeans(X, k, special_initialization)
    assert(isscalar(k));
    assert(k >= 1);
    assert(isa(special_initialization, 'logical'));
    
    % extract the number of examples in the dataset
    n_examples = size(X, 1);
    
    % initialize the prototypes
    if ~special_initialization
    
        % use random points
        prototypes_indexes = randperm(n_examples, k);
        prototypes = X(prototypes_indexes, :);
        
    else
        
        % special initialization procedure...
        first_prototype_index = randperm(n_examples, 1);
        prototypes = X(first_prototype_index, :);

        % initialize the other prototypes
        while size(prototypes, 1) < k

            % compute the probability distribution of the points
            % such that each point is choosen with probability proportional
            % to the distance from the closes prototype
            distances = pdist2(X, prototypes, 'squaredeuclidean');
            min_distances = min(distances, [], 2);
            probs = min_distances / sum(min_distances);
            assert(abs(sum(probs) - 1) <= 0.0000001);

            % select the next prototype according to the distribution
            next_index = randsample(1 : n_examples, 1, true, probs);
            next = X(next_index, :);

            % add the selected point to the list of prototypes
            prototypes(size(prototypes, 1) + 1, :) = next;
        end
    end
    
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
