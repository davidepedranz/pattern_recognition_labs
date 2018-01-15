clf; close all; clear; clc;

% load the data
X = [
    0 0;
    2 3;
    1 4;
    4 2;
    3 0;
];

% question 1
err1 = compute_error(X, [1 1 1 2 2]');
fprintf('Error for clustering of question 1: %f\n', err1);

% question 2
err2 = compute_error(X, [1 2 2 1 2]');
fprintf('Error for clustering of question 2: %f\n', err2);

% question 3
err3 = compute_error(X, [2 2 2 1 2]');
fprintf('Error for clustering of question 3: %f\n', err3);

% question 4
err4 = compute_error(X, [2 2 1 2 1]');
fprintf('Error for clustering of question 4: %f\n', err4);
