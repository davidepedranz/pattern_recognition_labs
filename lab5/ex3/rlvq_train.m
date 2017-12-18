function [prototypes, prototypes_classes, relevances, relevances_history, training_errors] = rlvq_train(X, y, n_prototypes, eta_weigths, eta_relevances, max_epochs)

    % assign a default value for the maximum number of epochs
    switch(nargin)
        case 5
            max_epochs = 1000;
    end

    % check the input
    assert(size(X, 1) == size(y, 1));
    assert(size(y, 2) == 1);
    assert(size(n_prototypes, 1) == length(unique(y)));
    assert(size(n_prototypes, 2) == 1);
    assert(isscalar(eta_weigths));
    assert(isscalar(eta_relevances));
    assert(isscalar(max_epochs));
    
    % setting: stopping criteria
    stability_epochs = 50;
    
    % extract some parameters
    n_examples = size(X, 1);
    n_features = size(X, 2);
    classes = unique(y);
    n_classes = length(classes);
    
    % compute the means for the different classes
    means = zeros(n_classes, n_features);
    for j = 1 : n_classes
        class = classes(j);
        examples = X(y == class, :);
        means(class, :) = mean(examples);
    end
    
    % initialize the prototypes
    % NB: we do not care that multiple prototypes are initialized with the
    % same values, since they will be updated differntly in the training
    total_prototypes = sum(n_prototypes);
    prototypes_classes = zeros(total_prototypes, 1) - 1;
    prototypes = zeros(total_prototypes, n_features);
    current_position = 0;
    for n = 1 : length(n_prototypes)
        for j = 1 : n_prototypes(n)
            current_position = current_position + 1;
            class = classes(n);
            prototypes_classes(current_position) = class;
            prototypes(current_position, :) = means(class, :);
        end
    end
    
    % initialize the relevances
    relevances = ones(n_features, 1) / n_features;
    
    % training
    training_errors = zeros(max_epochs, 1);
    relevances_history = zeros(max_epochs, n_features);
    for epoch = 1 : max_epochs
        fprintf(" - epoch %d -> ", epoch);
        
        % in each epoch, present all the examples
        for j = 1 : n_examples
            
            % extract the current training example
            example = X(j, :);
            label = y(j);
            
            % take the closest prototype
            distances = pdist2(example, prototypes, 'mahalanobis', diag(relevances)) .^ 2;
            [~, i] = min(distances);
            
            % update the corresponding prototype
            psi = sign((prototypes_classes(i) == label) - 0.5);
            prototypes(i, :) = prototypes(i, :) + eta_weigths * psi * (example - prototypes(i, :));
            
            % update the relevances (and normalize sum to 1)
            relevances = relevances - eta_relevances * psi * (example - prototypes(i, :))';
            relevances = relevances / sum(relevances);
        end
        
        % store the relevances
        relevances_history(epoch, :) = relevances;
        
        % compute the training error
        y_rlvq = rlvq_classify(X, prototypes, prototypes_classes, relevances);
        training_errors(epoch) = mean(y ~= y_rlvq);
        fprintf("error = %.4f\n",  training_errors(epoch));
        
        % stopping criteria: exit when the error is constant or starts to increase 
        if epoch >= stability_epochs
            indexes = (epoch - stability_epochs + 1) : epoch;
            last_errors = training_errors(indexes);
            p = polyfit(indexes', last_errors, 1);
            assert(length(p) == 2);
            if p >= 0
                break;
            end
        end
    end
    
    % return data only for the actual training epochs
    relevances_history = relevances_history(1 : epoch, :);
    training_errors = training_errors(1 : epoch);
end
