clf; close; clear;

% settings
limit = [-10 20];

% w1
p_w1 = 0.3;
mu_w1 = [3, 5];
sigma_w1 = [1 0; 0 4];

% w2
p_w2 = 0.7;
mu_w2 = [2, 1];
sigma_w2 = [2 0; 0 1];

% analitical border
figure;
hold on;
xlim(limit);
ylim(limit);
title('Decision Boundary');
xlabel('x (feature 1)');
ylabel('y (feature 2)');
boundary = fimplicit(@(x,y) -0.25*x^2 + 0.375*y^2 + 2*x + 0.25*y - 7.318871, '-r');
saveas(boundary, 'decision_boundary', 'png');
plot_gaussian(mu_w1, sigma_w1, limit);
plot_gaussian(mu_w2, sigma_w2, limit);
plot_points(p_w1, mu_w1, sigma_w1, p_w2, mu_w2, sigma_w2, limit);
hold off;
