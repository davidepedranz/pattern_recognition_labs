clf; close; clear;
rng(0);

% settings
p = 0.5;
rounds = 100;
people = 1000000;

% run the simulation of the game
simulation = zeros(people, rounds);
for round = 1:rounds
    for person = 1:people
        simulation(person, round) = rand > p;
    end
end
scores = sum(simulation, 2);
scores_mean = mean(scores);
scores_var = var(scores);

% plot histogram
plot_h = histogram(scores);
title('People End-Points in the Random Walk game');
xlabel('End-Points');
ylabel('Frequency');
saveas(plot_h, 'histogram', 'png');

% plot distribution on top of histogram
% plot 2 distributions + threashold
x = 25:1:75;
distribution = binopdf(x, rounds, p);
yyaxis right;
hold on;
plot_d = plot(x, distribution);
hold off;
ylabel('Density');
saveas(plot_d, 'distribution', 'png');

% estimated parameters
disp('Estimated Mean');
disp(scores_mean);
disp('Estimated Variance');
disp(scores_var);
