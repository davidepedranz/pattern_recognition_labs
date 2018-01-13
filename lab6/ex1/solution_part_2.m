clf; close all;
clear;

% fix the seed for the random numbers
rng(2);

% load the raw data
X = importdata('data/checkerboard.mat');
n_examples = size(X, 1);

% settings for the experiment
series = 10;
trials = 20;
k = 100;

% compute the quantization error
errors_normal = zeros(series, 1);
errors_special = zeros(series, 1);
for serie = 1 : series
    fprintf('Computing quantization error for serie %d...\n', serie);
    
    % run some trials
    trials_errors_normal = zeros(trials, 1);
    trials_errors_special = zeros(trials, 1);
    for trial = 1 : trials

        % normal kmeans
        [labels_normal, means_normal, ~] = kmeans(X, k, false);
        trials_errors_normal(trial) = quantization_error(X, labels_normal, means_normal);

        % kmeans++
        [labels_special, means_special, ~] = kmeans(X, k, true);
        trials_errors_special(trial) = quantization_error(X, labels_special, means_special);
    end
    
    % take the best result
    errors_normal(serie) = min(trials_errors_normal);
    errors_special(serie) = min(trials_errors_special);
end

% answers for the questions
mean_error_normal = mean(errors_normal);
std_error_normal = std(errors_normal);
mean_error_special = mean(errors_special);
std_error_special = std(errors_special);
fprintf('k-means normal error: mean = %.2f, std = %.2f\n', mean_error_normal, std_error_normal);
fprintf('k-means++      error: mean = %.2f, std = %.2f\n', mean_error_special, std_error_special);

% statistical Welch’s t-test
[h, p] = ttest2(errors_normal, errors_special, 'Vartype', 'unequal');
fprintf('p-value for Welch t-test: %.5f\n', p);
if h && mean_error_normal > mean_error_special
    fprintf('Special initialization yields better performances\n');
else
    fprintf('Special initialization does NOT yield better performances\n');
end
    
    