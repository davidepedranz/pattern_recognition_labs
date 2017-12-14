clf; close all;
clear;

% load the image
cameraman = imread('data/Cameraman.tiff');

% compute the edges using the Canny algorithm
edges = edge(cameraman, 'canny');

% compute the hough transform
[accumulator, theta, rho] = hough(edges);

% plot the hough transform
imshow(imadjust(rescale(accumulator)), 'XData', theta, 'YData', rho, 'InitialMagnification', 'fit');
title('Hough transform of Cameraman.tiff');
xlabel('\theta');
ylabel('\rho');
axis on;
axis normal;
hold on;
saveas(gcf, 'hough', 'png');

% filter out only the strongest values in the accumulator
accumulator_high_values = accumulator;
max_value = max(accumulator_high_values(:));
threshold = 0.999 * max_value;
accumulator_high_values(accumulator_high_values < threshold) = 0;

% find the maximum
strongest_peak = houghpeaks(accumulator_high_values, 1);

% find the peaks
peaks = houghpeaks(accumulator, 5);
hold on;
plot(theta(peaks(:, 2)), rho(peaks(:, 1)), 's', 'color', 'red');
hold off;
saveas(gcf, 'peaks', 'png');

% plot the line for the strongest peak
my_rho = rho(strongest_peak(:, 1));
my_theta = theta(strongest_peak(:, 2));
myhoughline(cameraman, my_rho, my_theta);
saveas(gcf, 'line', 'png');

% --------------------------------------------

% some nice extra plot [this was NOT part of the exercise]
figure;
subplot(2, 2, 1);
imshow(cameraman);
subplot(2, 2, 2);
imshow(edges);
subplot(2, 2, 3);
imshow(cameraman);
subplot(2, 2, 4);
imshow(edges);
for k = 1:length(peaks)
    current_rho = rho(peaks(k, 1));
    current_theta = theta(peaks(k, 2));
    for plot = [3, 4]
        subplot(2, 2, plot);
        myhoughline(cameraman, current_rho, current_theta, false);
    end
end
