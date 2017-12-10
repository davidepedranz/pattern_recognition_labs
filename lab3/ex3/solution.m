clf; close;
clear;
format long;

% settings
n_classes = 3;

% load data
for i = 1:n_classes
    examples(:, :, i) = importdata(sprintf('data/lab3_3_cat%d.mat', i)); %#ok<SAGROW>
end

% figure;
% scatter3(examples_c1(:, 1), examples_c1(:, 2), examples_c1(:, 3), 'b*');
% hold on;
% scatter3(examples_c2(:, 1), examples_c2(:, 2), examples_c2(:, 3), 'r+');
% scatter3(examples_c3(:, 1), examples_c3(:, 2), examples_c3(:, 3), 'g^');
% hold off;

% data from questions
u = [0.5, 1, 0];
v = [0.31, 1.51, -0.5];
w = [-1.7, -1.7, -1.7];
X = [u; v; w];

% answer the questions
solve_parzen(X, examples, 1);
solve_parzen(X, examples, 2);

% load KNN
addpath(genpath('../ex2'));

% tranform data for KNN
n_examples = size(examples, 1);
data = zeros(n_examples * n_classes, size(examples, 2));
labels = zeros(n_examples * n_classes, 1);
for class = 1:n_classes
    offset = n_examples * (class - 1);
    data((1 + offset) : (n_examples + offset), :) = examples(:, :, class);
    labels((1 + offset) : (n_examples + offset)) = ones(n_examples, 1) * class;
end

% KNN (k=1)
class_u_k_1 = KNN(u, 1, data, labels);
class_v_k_1 = KNN(v, 1, data, labels);
class_w_k_1 = KNN(w, 1, data, labels);
fprintf('Class for point u using KNN k=1 -> %d\n', class_u_k_1);
fprintf('Class for point v using KNN k=1 -> %d\n', class_v_k_1);
fprintf('Class for point w using KNN k=1 -> %d\n\n', class_w_k_1);

% KNN (k=5)
class_u_k_5 = KNN(u, 5, data, labels);
class_v_k_5 = KNN(u, 5, data, labels);
class_w_k_5 = KNN(u, 5, data, labels);
fprintf('Class for point u using KNN k=5 -> %d\n', class_u_k_5);
fprintf('Class for point v using KNN k=5 -> %d\n', class_v_k_5);
fprintf('Class for point w using KNN k=5 -> %d\n', class_w_k_5);
