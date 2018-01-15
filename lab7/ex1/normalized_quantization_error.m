function error = normalized_quantization_error(X, clusters)
    %%QUANTIZATION_ERROR: compute the quantization error of a clustering
    %%algorithm based on the bins. The error is multiplied by the number of
    %%clusters for a more fair comparison.
    
    % extract the dimension of the dataset
    [n, dim] = size(X);
    
    % compute the centers of the clustering
    centers = splitapply(@(x) mean(x, 1), X, clusters);
    
    % compute the distances from the prototypes
    distances = pdist2(X, centers, 'squaredeuclidean');
    
    % compute the error
    errors = zeros(n, 1);
    for i = 1 : size(X, 1)
        label = clusters(i);
        errors(i) = distances(i, label);
    end
    error = sum(errors) / 2 * (length(centers) ^ (2 / dim));
end
