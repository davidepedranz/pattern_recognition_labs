clf; close all;
clear;

% load the image
chess_rgb = imread('data/chess.jpg');
chess = rgb2gray(chess_rgb);

% compute the edges using the Canny algorithm
edges = edge(chess, 'canny');

% hough transform
[accumulator, theta, rho] = hough(edges);

% load myhoughline
addpath(genpath('../ex1'));

% find the peaks
peaks = houghpeaks(accumulator, 15);

% show the plot of Hough space
figure;
imshow(imadjust(rescale(accumulator)), 'XData', theta, 'YData', rho, 'InitialMagnification', 'fit');
title('Hough transform of chess.jpg with peaks');
xlabel('\theta');
ylabel('\rho');
axis on;
axis normal;
hold on;
plot(theta(peaks(:, 2)), rho(peaks(:, 1)), 's', 'color', 'red');
hold off;
saveas(gcf, 'peaks', 'png');

% image of chess + lines
figure;
imshow(chess);
for k = 1:length(peaks)
    current_rho = rho(peaks(k, 1));
    current_theta = theta(peaks(k, 2));
    myhoughline(chess, current_rho, current_theta, false);
end
saveas(gcf, 'chess_with_lines', 'png');

% some nice extra plot ;-)
figure;
subplot(2, 2, 1);
imshow(chess);
subplot(2, 2, 2);
imshow(edges);
subplot(2, 2, 3);
imshow(chess);
subplot(2, 2, 4);
imshow(edges);
for k = 1:length(peaks)
    current_rho = rho(peaks(k, 1));
    current_theta = theta(peaks(k, 2));
    for plot = [3, 4]
        subplot(2, 2, plot);
        myhoughline(chess, current_rho, current_theta, false);
    end
end
saveas(gcf, 'comparison', 'png');
