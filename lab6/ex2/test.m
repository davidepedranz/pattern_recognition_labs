clf; close all; clear; clc;

% load the dataset
X = importdata('data/checkerboard.mat');

% run the base implementation
rng(0);
tic;
figure;
p1 = seqBatchNG(X, 100, 20);
toc;

% run the parallel implementation
rng(0);
tic;
figure;
p2 = batchNG(X, 100, 20);
toc;

% check that they give the same result
fprintf('equal = %d\n', all(p1(:) - p2(:) < 0.00001));
