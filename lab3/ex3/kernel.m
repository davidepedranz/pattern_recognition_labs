function result = kernel(X, example, h)
    assert(size(X, 2) == size(example, 2));
    assert(size(example, 1) == 1);
    
    result = ones(size(X, 1), 1);
    for i = 1:size(X, 2)
        result = result .* normpdf(X(:, i), example(i), h);
    end
end
