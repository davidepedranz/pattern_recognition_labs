function prob = estimator(X, examples, h)
    assert(size(X, 2) == size(examples, 2), "The number of features (columns) of X and examples must be the same");
    
    n = size(examples, 1);
    prob = zeros(size(X, 1), 1);
    for j = 1:n
        prob = prob + kernel(X, examples(j, :), h);
    end
    prob = prob / n;
end
