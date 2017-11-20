clf; close; close; clear;
format long;

% settings
n_persons = 20;
iterations = 10000;
false_accemptance_error = 0.0005;

% fix random generator seed (for reproducible results)
rng(0);

% pre-load persons
persons = cell(n_persons, 1);
for i=1:n_persons
    person_raw = load(sprintf('data/person%02d.mat', i));
    persons{i} = person_raw.iriscode;
end

% create set S (HD of pairs of examples from the same person)
S = zeros(iterations, 1);
for i=1:iterations
    
    % select some random person
    person = persons{ceil(rand * n_persons)};
    rows_number = size(person, 1);

    % extract example 1
    row_1_index = ceil(rand * rows_number);
    row_1 = person(row_1_index, :);
    
    % extract example 2
    row_2_index = ceil(rand * rows_number);
    row_2 = person(row_2_index, :);

    % compute the distance
    S(i) = hamming_distance(row_1, row_2);
end

% create set D (HD of pairs of examples from different persons)
D = zeros(iterations, 1);
for i=1:iterations
    
    % fix an order, so we are sure to pick 2 different persons
    order = randperm(20);

    % load example from person 1
    person_1 = persons{order(1)};
    rows_number_1 = size(person_1, 1);
    row_1_index = ceil(rand * rows_number_1);
    row_1 = person_1(row_1_index, :);
    
    % load example from person 2
    person_2 = persons{order(2)};
    rows_number_2 = size(person_2, 1);
    row_2_index = ceil(rand * rows_number_2);
    row_2 = person_2(row_2_index, :);

    % compute the distance
    D(i) = hamming_distance(row_1, row_2);
end

% plot
edges = 0:0.01:1;
hist_s = histogram(S, 'BinEdges', edges);
hold on;
hist_d = histogram(D, 'BinEdges', edges);
hold off;
xlim([0, 1]);
title('Binary Iris Codes Frequencies');
xlabel('Normalized Hamming Distance');
ylabel('Frequency');
legend([hist_s, hist_d], 'same person', 'different person');
saveas(hist_d, 'histogram', 'png');

% questions
mean_s = mean(S);
disp('Mean of S:');
disp(mean_s);
var_s = var(S);
std_s = std(S);
disp('Variance of S:');
disp(var_s);
mean_d = mean(D);
disp('Mean of D:');
disp(mean_d);
var_d = var(D);
std_d = std(D);
disp('Variance of D:');
disp(var_d);

% compute threashold
d = icdf('Normal', false_accemptance_error, mean_d, std_d);
disp('Threashold:');
disp(d);

% ------------
% check (verify use of `icdf`)
% ------------
% x = 0.15:0.005:0.2;
% y = zeros(1, length(x));
% for i=1:length(y)
%    y(i) = normcdf(x(i), mean_d, std_d);
% end
% disp([x; y; y < false_accemptance_error])
% ------------

% false rejection rate
false_rejection = 1 - normcdf(d, mean_s, std_s);
disp('False Rejection Rate:');
disp(false_rejection);

% plot 2 distributions + threashold
x = 0:0.001:1;
distribution_s = normpdf(x, mean_s, std_s);
distribution_d = normpdf(x, mean_d, std_d);
ylabel('Frequency (histograms)');
yyaxis right;
hold on;
plot_s = plot(x, distribution_s, 'Color', 'blue');
plot_d = plot(x, distribution_d, 'Color', [1 .5 0]);
hold off;
xlim([0, 1]);
line([d d], ylim, 'Color', 'red', 'LineStyle', '-.');
title('Binary Iris Codes Distribution');
xlabel('Normalized Hamming Distance');
ylabel('Frequency (distributions)');
legend([hist_s, hist_d, plot_s, plot_d], {'same person (observations)', 'different person (observations)', 'same person (distribution)', 'different person (distribution)'});
saveas(plot_d, 'distribution', 'png');

% estimate degrees of freedom
degrees = mean_d * (1 - mean_d) / (std_d ^ 2);
disp('Degrees of freedom:');
disp(degrees);

% test person
test_person_raw = load('data/testperson.mat');
test_person = test_person_raw.iriscode;

% measure similarities of test person with the others
% note that we average over all examples for each person
scores_matrix = cellfun(@(x) arrayfun(@(i) hamming_distance(x(i, :), test_person), 1:size(x, 1)), persons, 'uniformoutput', false);
scores = cellfun(@(x) mean(x), scores_matrix);
scores_std = cellfun(@(x) std(x), scores_matrix);
[~, class] = min(scores);
disp('Test person corresponds to person:');
disp(class);
disp('Score:');
disp(scores(class));
disp('Score std:');
disp(scores_std(class));

% compute the confidence
n = sum(test_person ~= 2);
confidence = 1 - normpdf(scores(class), mean_d, sqrt(mean_d * (1 - mean_d) / n));
disp('Confidence');
disp(confidence);

% visualize shapes of the HD distribution for a different number of bits n
figure;
hold on;
plot(x, normpdf(x, 0.5, sqrt(0.5 ^ 2 / 10)));
plot(x, normpdf(x, 0.5, sqrt(0.5 ^ 2 / 20)));
plot(x, normpdf(x, 0.5, sqrt(0.5 ^ 2 / 30)));
plot(x, normpdf(x, mean_d, std_d));
xlim([0 1]);
title('Binary Iris Codes Distribution with Missing Features');
xlabel('Normalized Hamming Distance');
ylabel('Frequency');
legend({'n=10', 'n=20', 'n=30', 'real (n=30)'})
hold off;
