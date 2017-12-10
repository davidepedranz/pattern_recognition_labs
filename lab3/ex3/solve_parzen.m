function solve_parzen(X, examples, h)

    % compute the likelihoods for the various classes using our kernel estimators
    n_points = size(X, 1);
    n_classes = size(examples, 3);
    likelihoods = zeros(n_points, n_classes);
    for class = 1:n_classes
        likelihoods(:, class) = estimator(X, examples(:, :, class), h);
    end

    % print the likelihoods
    fprintf('[LIKELIHOODS] h = %d\n', h);
    for point = 1:n_points
        fprintf('point %d -> ', point);
        for class = 1:n_classes
            fprintf('P(x | class = %d) = %f, ', class, likelihoods(point, class));
        end
        fprintf('\n');
    end
    fprintf('\n');

    % priors
    priors = ones(n_classes, 1) / n_classes;

    % posteriors
    posteriors = zeros(size(likelihoods));
    for i = 1:size(likelihoods, 1)
        current_likelihoods = likelihoods(i, :);
        current_posteriors_not_normalized = current_likelihoods .* priors';
        posteriors(i, :) = current_posteriors_not_normalized / sum(current_posteriors_not_normalized);
    end

    % compute classes
    [~, classes] = max(posteriors, [], 2);

    % print the posteriors
    fprintf('[POSTERIORS] h = %d\n', h);
    for point = 1:n_points
        fprintf('point %d -> ', point);
        for class = 1:n_classes
            fprintf('P(class = %d | x) = %f, ', class, posteriors(point, class));
        end
        fprintf('class = %d', classes(point));
        fprintf('\n');
    end
    fprintf('\n');
end

