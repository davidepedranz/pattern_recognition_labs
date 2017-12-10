clf; close; close; 
clear;
format long;

% input
mu_1 = 5;
mu_2 = 7;
sigma = 2;
threshold = 10;

% question 1: P(hit)
p_hit = 1 - normcdf(threshold, mu_2, sigma);
fprintf('p_hit = %.6f\n', p_hit);

% question 2: P(false alarm)
p_fa = 1 - normcdf(threshold, mu_1, sigma);
fprintf('p_fa = %.6f\n', p_fa);

% question 3,4: discriminability
d1 = discriminability(mu_1, mu_2, sigma);
fprintf('discriminability (3) = %.6f\n', d1);
d2 = discriminability(5, 9, sqrt(4));
fprintf('discriminability (4) = %.6f\n', d2);
q5 = 3 * sigma + 5;
fprintf('mu_2 (5) = %.6f\n', q5);

% question 7-10
data = importdata('data/lab3_1.mat');
tp = sum(ismember(data, [1 1], 'rows'));
fn = sum(ismember(data, [1 0], 'rows'));
fp = sum(ismember(data, [0 1], 'rows'));
tn = sum(ismember(data, [0 0], 'rows'));
hit_rate = tp / (tp + fn);
fa_rate = 1 - (tn / (fp + tn));
fprintf('hit_rate = %.6f\n', hit_rate);
fprintf('fa_rate = %.6f\n', fa_rate);

% ROC curve
my_sigma = 0.94163665;
x = 0:0.1:20;
false_positive_rate = 1 - normcdf(x, mu_1, my_sigma);
true_positive_rate = 1 - normcdf(x, mu_2, my_sigma);
figure;
plot(fa_rate, hit_rate, 'ro', 'markers', 4);
title(sprintf('ROC curve for \\mu_1=%d, \\mu_2=%d, \\sigma=%.6f', mu_1, mu_2, my_sigma));
xlabel('False Positive Rate');
ylabel('True Positive Rate');
pbaspect([1 1 1]);
hold on;
plot(false_positive_rate, true_positive_rate);
hold off;
% xlim([0.099999, 0.100001]);
% ylim([0.799999, 0.800001]);
saveas(gcf, 'roc', 'png');

roc_discriminability = discriminability(mu_1, mu_2, my_sigma);
fprintf('roc_discriminability = %.6f\n', roc_discriminability);

function value = discriminability(mu_1, mu_2, sigma) 
    value = abs(mu_2 - mu_1) / sigma;
end