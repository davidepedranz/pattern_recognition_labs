clear;
format long;

% input data
data = [
    4 6 8 7 4;
    5 3 7 4 6;
    6 9 3 8 5
]';

% mean
m = mean(data);
disp('Means');
disp(m);

% covariance (biased)
dim = size(data, 1);
covariance = (data - m)' * (data - m) / dim;
disp('Biased Covariance Matrix');
disp(covariance);

% check - covariance
unbiased_cov = cov(data);
biased_cov = unbiased_cov * (dim - 1)  /  dim;
disp('Matlab Biased Covariance Matrix (check)');
disp(biased_cov);

% answer questions
p1 = mvnpdf([5 5 6], m, covariance);
fprintf('Value for [5 5 6] = %.6f\n', p1)

p2 = mvnpdf([3 5 7], m, covariance);
fprintf('Value for [3 5 7] = %.6f\n', p2)

p3 = mvnpdf([4 6.5 1], m, covariance);
fprintf('Value for [4 6.5 1] = %s\n', p3)

