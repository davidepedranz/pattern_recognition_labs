function error = quantization_error(X, prototypes)
    %%QUANTIZATION_ERROR: compute the quantization error of a clustering
    %%algorithm given the dataset and the found prototypes. Clusters will
    %%be computed taking the closest prototype for each point.
    
    % validate the input
    assert(size(X, 2) == size(prototypes, 2));
    
    % compute the distances from the prototypes
    distances = pdist2(X, prototypes, 'squaredeuclidean');
    
    % assign points to the clusters
    [~, clusters] = min(distances, [], 2);

    % compute the error
    errors = zeros(size(X, 1), 1);
    for i = 1 : size(X, 1)
        label = clusters(i);
        errors(i) = distances(i, label);
    end
    error = sum(errors) / 2;
end
