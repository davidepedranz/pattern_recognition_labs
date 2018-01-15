function err = compute_error(X, clusters)
    %%COMPUTE_ERROR ...
    
    % compute the centers of the clustering
    centers = splitapply(@(x) mean(x, 1), X, clusters);

    % compute the distances from the prototypes
    distances = pdist2(X, centers, 'squaredeuclidean');

    % compute the error
    n = size(X, 1);
    errors = zeros(n, 1);
    for i = 1 : n
        label = clusters(i);
        errors(i) = distances(i, label);
    end
    err = sum(errors);
end
