clf;
close; close; close; close; close;
close; close; close; close; close;
clear;
load lab3_2.mat;

% settings
ks = [1 3 5 7];
samples = 64;
data = lab3_2;
nr_of_classes = 2;

% labels for 2 classes
class_labels = floor((0:length(data) - 1) * nr_of_classes / length(data));
labels = class_labels';

% classify
result_1 = classify(1, data, class_labels, samples);
result_3 = classify(3, data, class_labels, samples);
result_5 = classify(5, data, class_labels, samples);
result_7 = classify(7, data, class_labels, samples);
visualize(result_1, 1, data, labels, samples);
visualize(result_3, 3, data, labels, samples);
visualize(result_5, 5, data, labels, samples);
visualize(result_7, 7, data, labels, samples);

% evaluate: leave-one-out
errors_rate_3 = loovc(data, labels, 3);
errors_rate_17 = loovc(data, labels, 17);
fprintf('error rate for k=3  -> %.6f\n', errors_rate_3);
fprintf('error rate for k=17 -> %.6f\n', errors_rate_17);

% plot choice of K
all_ks = 1:25;
errors_rates = arrayfun(@(k) loovc(data, labels, k), all_ks);
plot(all_ks, errors_rates);
xlimits = xlim;
xticks(xlimits(1):1:(xlimits(2)));
ylimits = ylim;
yticks(ylimits(1):0.01:(ylimits(2)));
title('Classification errors for KNN for different values of K');
xlabel('K');
ylabel('Errors Rate');
saveas(gcf, 'classification_errors_2_classes', 'png');

% select best K
[min_error, min_index] = min(errors_rates);
best_k = all_ks(min_index);
fprintf('Best K=%d with error_rate=%.4f for 2 classes\n', best_k, min_error);

% classification for 4 classes
labels_4_classes = [zeros(50, 1); ones(50, 1); ones(50, 1) * 2; ones(50, 1) * 3];
result_4_classes_k_1 = classify(1, data, labels_4_classes, samples);
result_4_classes_k_3 = classify(3, data, labels_4_classes, samples);
result_4_classes_k_5 = classify(5, data, labels_4_classes, samples);
result_4_classes_k_7 = classify(7, data, labels_4_classes, samples);
visualize(result_4_classes_k_1, 1, data, labels_4_classes, samples);
visualize(result_4_classes_k_3, 3, data, labels_4_classes, samples);
visualize(result_4_classes_k_5, 5, data, labels_4_classes, samples);
visualize(result_4_classes_k_7, 7, data, labels_4_classes, samples);

% plot choice of K for 4 classes
errors_rates_4_classes = arrayfun(@(k) loovc(data, labels_4_classes, k), all_ks);
plot(all_ks, errors_rates_4_classes);
xlimits = xlim;
xticks(xlimits(1):1:(xlimits(2)));
ylimits = ylim;
yticks(xlimits(1):0.01:(xlimits(2)));
title('Classification errors for KNN for different values of K (4 classes)');
xlabel('K');
ylabel('Errors Rate');
saveas(gcf, 'classification_errors_4_classes', 'png');

% select best K
[min_error_4_classes, min_index_4_classes] = min(errors_rates_4_classes);
best_k_4_classes = all_ks(min_index_4_classes);
fprintf('Best K=%d with error_rate=%.4f for 4 classes\n', best_k_4_classes, min_error_4_classes);

function error_rate = loovc(data, labels, k)
    assert(size(data, 1) == size(labels, 1), "Size mismatch between data and labels");
    partition = cvpartition(size(data, 1), 'LeaveOut');
    tmp = @(x_train, y_train, x_test, y_test) xxx(k, x_train, y_train, x_test, y_test);
    errors = crossval(tmp, data, labels, 'partition', partition);
    error_rate = mean(errors);
end

function errors = xxx(k, x_train, y_train, x_test, y_test)
    y = arrayfun(@(row_index) KNN(x_test(row_index, :), k, x_train, y_train), 1:size(x_test, 1));
    errors = y ~= y_test;
end

function result = classify(K, data, class_labels, samples)
    % Sample the parameter space
    result = zeros(samples);
    for i = 1:samples
        X = (i - 1 / 2) / samples;
        for j = 1:samples
            Y = (j - 1 / 2) / samples;
            result(j,i) = KNN([X Y], K, data, class_labels);
        end
    end
end

function visualize(result, K, data, labels, samples)
    % Show the results in a figure
    figure;
    nr_of_classes = length(unique(result));
    imshow(result, [0 nr_of_classes - 1], 'InitialMagnification', 'fit')
    hold on;
    title([int2str(K) '-NN, ' int2str(nr_of_classes) ' classes']);
    scaled_data = samples * data;
    gscatter(scaled_data(:, 1), scaled_data(:, 2), labels, 'gbrc', 'o*+^');
    hold off;
end
