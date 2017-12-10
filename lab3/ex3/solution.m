clf; close;
clear;
format long;

% settings
h = 1;

% load data
examples_c1 = importdata('data/lab3_3_cat1.mat');
examples_c2 = importdata('data/lab3_3_cat2.mat');
examples_c3 = importdata('data/lab3_3_cat3.mat');
examples(:, :, 1) = examples_c1;
examples(:, :, 2) = examples_c2;
examples(:, :, 3) = examples_c3;

% data from questions
u = [0.5, 1, 0];
v = [0.31, 1.51, -0.5];
w = [-1.7, -1.7, -1.7];
X = [u; v; w];

% compute the estimators for the various classes
n_classes = size(examples, 3);
estimators = zeros(size(X, 1), n_classes);
for class = 1:n_classes
    estimators(:, class) = estimator(X, examples(:, :, class), h);
end

% figure;
% scatter3(examples_c1(:, 1), examples_c1(:, 2), examples_c1(:, 3), 'b*');
% hold on;
% scatter3(examples_c2(:, 1), examples_c2(:, 2), examples_c2(:, 3), 'r+');
% scatter3(examples_c3(:, 1), examples_c3(:, 2), examples_c3(:, 3), 'g^');
% hold off;

