function folds = n_fold(n_examples, n_folds)
    folds = zeros(n_examples, n_folds);
    for i = 1 : n_folds
        folds(:, i) = (1 + mod((1 : n_examples)', n_folds)) ~= i;
    end
end
