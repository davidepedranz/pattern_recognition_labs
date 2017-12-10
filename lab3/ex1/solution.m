clf; close; close; clear;
format long;

% input
mu_1 = 5;
mu_2 = 7;
sigma = 2;
threshold = 10;

% question 1: P(hit)
p_hit = 1 - normcdf(threshold, mu_2, sigma);
fprintf("p_hit = %.6f\n", p_hit);

% question 2: P(false alarm)
p_fa = 1 - normcdf(threshold, mu_1, sigma);
fprintf("p_fa = %.6f\n", p_fa);

% question 3,4: discriminability
d1 = abs(mu_2 - mu_1) / sigma;
fprintf("discriminability (3) = %.6f\n", d1);
d2 = abs(9 - 4) / sigma;
fprintf("discriminability (4) = %.6f\n", d2);
q5 = 3 * sigma + 5;
fprintf("mu_2 (5) = %.6f\n", q5);

% question 7-10
data = importdata('data/lab3_1.mat');
tp = sum(ismember(data, [1 1], 'rows'));
fn = sum(ismember(data, [1 0], 'rows'));
fp = sum(ismember(data, [0 1], 'rows'));
tn = sum(ismember(data, [0 0], 'rows'));
hit_rate = tp / (tp + fn);
fa_rate = 1 - (tn / (fp + tn));
fprintf("hit_rate = %.6f\n", hit_rate);
fprintf("fa_rate = %.6f\n", fa_rate);

