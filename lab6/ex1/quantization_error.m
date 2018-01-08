function error = quantization_error(X, clusters, prototypes)
    assert(size(X, 1) == size(clusters, 1));
    assert(size(prototypes, 1) == length(unique(clusters)));
    assert(size(X, 2) == size(prototypes, 2));
    assert(size(clusters, 2) == 1);
    
    errors = zeros(size(X, 1), 1);
    for i = 1 : size(X, 1)
        example = X(i, :);
        label = clusters(i);
        prototype = prototypes(label, :);
        errors(i) = pdist2(example, prototype, 'squaredeuclidean');
    end
    
    error = sum(errors) / 2;
end
