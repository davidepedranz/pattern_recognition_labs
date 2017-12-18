function y = lvq_classify(X, prototypes, prototypes_classes)

    % compute the distance of each example from the prototypes
    distances = pdist2(X, prototypes, 'euclidean') .^ 2;
    
    % compute the closest prototype for each example
    [~, indexes] = min(distances, [], 2);

    % finally, perform the classification
    y = prototypes_classes(indexes);
end
