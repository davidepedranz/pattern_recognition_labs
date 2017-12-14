clf; close all;
clear;

% load the image
cameraman = imread('data/Cameraman.tiff');

% compute the edges using the Canny algorithm
edges = edge(cameraman, 'canny');

% hough transform
[accumulator, theta, rho] = myhough(edges);
[accumulator_real, theta_real, rho_real] = hough(edges);

% plot our implementation
figure;
subplot(1, 2, 1);
imshow(imadjust(rescale(accumulator)), 'XData', theta, 'YData', rho, 'InitialMagnification', 'fit');
title('[Our] Hough transform of Cameraman.tiff');
xlabel('\theta');
ylabel('\rho');
axis on;
axis normal;
hold on;
colormap(gca, 'hot');

% plot matlab implementation
subplot(1, 2, 2);
imshow(imadjust(rescale(accumulator_real)), 'XData', theta_real, 'YData', rho_real, 'InitialMagnification', 'fit');
title('[Matlab] Hough transform of Cameraman.tiff');
xlabel('\theta');
ylabel('\rho');
axis on;
axis normal;
hold on;
colormap(gca, 'hot');

% save the plot
saveas(gcf, 'hough_comparison', 'png');

% load myhoughline
addpath(genpath('../ex1'));

% compute some peaks
peaks = houghpeaks(accumulator, 3);

% some nice extra plot ;-)
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
saveas(gcf, 'cameraman_with_lines', 'png');
