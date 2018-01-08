clf; close all;
clear;

% fix the seed for the random numbers
rng(0);

% settings for the plots
rgb_colors = [
    228,26,28;
    55,126,184;
    77,175,74;
    152,78,163;
    255,127,0;
    255,220,15;
    166,86,40;
    247,129,191;
];
colors = rgb_colors / 256;
markers = '+o*<sxd^';

% prepare the folder for the results
mkdir('output');

% load the raw data
X = importdata('data/kmeans1.mat');
n_examples = size(X, 1);
n_dimensions = size(X, 2);

% kmeans for different k
ks = [2, 4, 8];
for index = 1 : length(ks)
    k = ks(index);

    % cluster
    [labels, means, history] = kmeans(X, k);
    
    % plot
    figure;
    gscatter(X(:, 1), X(:, 2), labels, colors, markers, [], 'off');
    hold on;
    gscatter(means(:, 1), means(:, 2), 1:k, 'k', '.', 36, 'off');
    hold off;
    saveas(gcf, sprintf('output/cluster_k%d', k), 'png');
            
    % plot history of prototypes
    figure;
    hold on;
    for h = 2 : size(history, 3)
        for p = 1 : size(history, 1)
            previous = history(p, :, h - 1);
            current = history(p, :, h);
            color = colors(p, :);
            plot_arrow(previous(1), previous(2), current(1), current(2), ...
                'linewidth', 2, 'headwidth', 0.06, 'headheight', 0.09, ...
                'color', color, 'facecolor', color, 'edgecolor', color);
        end
    end
    hold off;
end

% compute the errors
trials = 20;
ks = (1 : 25)';
jk = zeros(length(ks), 1);
for i = 1 : length(ks)
    k = ks(i);
    fprintf('Computing error for k=%d...\n', k);
    errors = zeros(trials, 1);
    for trial = 1 : trials
        [labels, means, ~] = kmeans(X, k);
        errors(trial) = quantization_error(X, labels, means);
    end
    jk(i) = mean(errors);
end
rk = jk(1) * ks .^ (-2 / n_dimensions);
assert(rk(1) == jk(1));
dk = rk ./ jk;

% compute k_optimal
[~, k_opt_index] = max(dk);
k_opt = ks(k_opt_index);

% question 4
figure;
plot(ks, dk);
hold on;
plot([k_opt k_opt], ylim);
hold off;
title('D(k) = R(k) / J(k)');
xlabel('k');
ylabel('D(k)');
saveas(gcf, 'output/dk', 'png');

% question 5
figure;
plot(ks, jk);
hold on;
plot(ks, rk, 'color', 'g');
plot([k_opt k_opt], ylim, 'color', 'r');
hold off;
title('Quantization Error J(k)');
xlabel('k');
xticks(ks);
legend({'J(k)', 'R(k)'})
saveas(gcf, 'output/jk_rk', 'png');
