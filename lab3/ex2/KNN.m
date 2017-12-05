function class = KNN(point, K, data, class_labels)
    labels = class_labels(:);

    assert(size(point, 1) == 1, "The point should be an orizzontal vector");
    assert(size(point, 2) == size(data, 2), "Size mismatch between the point and the data matrix");
    assert(size(data, 1) == size(labels, 1), "Size mismatch between data and labels");
    
    distances = sqrt(sum((data - point) .^ 2, 2));
    neighbours = sortrows([distances, labels]);
    k_nn_labels = neighbours(1:K, 2);
    unique_classes = unique(labels);
    counts = arrayfun(@(class) sum(k_nn_labels == class), unique_classes);
    [~, class_index] = max(counts);
    class = unique_classes(class_index);
end
