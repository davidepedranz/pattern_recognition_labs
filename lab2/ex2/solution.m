clear;

% symbolic computation
syms a b c d k;

% data
X = [a c ; b d];
dim = size(X, 1);

% question 1
m = mean(X);
covariance = (X - m) * (X - m)' / dim;
disp(covariance);

% question 2
X1 = X + k;
m1 = mean(X1);
disp('X - m');
disp(X - m);
disp('X1 - m1');
disp(X1 - m1);
disp('Covariance of X + k does is equal to the one of k');

% question 3
X2 = X * k;
m2 = mean(X2);
disp('X2 - m2');
disp(X2 - m2);
disp('Covariance of X * k does is multiplied by k^2 with respect to X');

