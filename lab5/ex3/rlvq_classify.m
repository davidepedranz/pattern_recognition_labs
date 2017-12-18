function y = rlvq_classify(X, prototypes, prototypes_classes, relevances)

    % compute the distance of each example from the prototypes
    distances = pdist2(X, prototypes, 'mahalanobis', diag(relevances)) .^ 2;
    
    % compute the closest prototype for each example
    [~, indexes] = min(distances, [], 2);

    % finally, perform the classification
    y = prototypes_classes(indexes);
end
