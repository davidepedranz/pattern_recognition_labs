clf; close; close; clear;
format long;

% load the example data
lab1_1 = load('data/lab1_1.mat');
data = lab1_1.lab1_1;
features = ['height (cm)'; 'age (years)'; 'weight (kg)'];
disp('features (in order):')
disp(features);

% compute the pair-wise correlation coefficients between the features
correlation_coefficients = corrcoef(data);
disp('pair-wise correlation coefficients between the features:')
disp(correlation_coefficients);

% largest correlated features
largest = replace_highest_values(correlation_coefficients);
[~, first] = max(largest(:));
[first_f2, first_f1] = ind2sub(size(largest), first);
plot_largest = plot(data(:, first_f1), data(:, first_f2), 'or');
xlabel(features(first_f1, :));
ylabel(features(first_f2, :));
title('Features with the Largest Correlation');
saveas(plot_largest, 'largest', 'png');

% second correlated features
second_largest = replace_highest_values(largest);
[~, second] = max(second_largest(:));
[second_f2, second_f1] = ind2sub(size(second_largest), second);
figure;
plot_second_largest = plot(data(:, second_f1), data(:, second_f2), 'or');
xlabel(features(second_f1, :));
ylabel(features(second_f2, :));
title('Features with the Second Largest Correlation');
saveas(plot_second_largest, 'second_largest', 'png');

% answer for question 15... check correlations for age > 40 and < 40
cc_less_40 = corrcoef(data(data(:, 2) < 40, :));
disp('pair-wise correlation coefficients between the features (ONLY age < 40):')
disp(cc_less_40);
cc_more_40 = corrcoef(data(data(:, 2) > 40, :));
disp('pair-wise correlation coefficients between the features (ONLY age > 40):')
disp(cc_more_40);
