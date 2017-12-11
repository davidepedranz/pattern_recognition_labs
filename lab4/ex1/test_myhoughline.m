clf; close all;
clear;

cameraman = imread('data/Cameraman.tiff');
edges = edge(cameraman, 'canny');
[accumulator, theta, rho] = hough(edges);
peaks = houghpeaks(accumulator, 5);

% test the `myhoughline` function
lines = houghlines(edges, theta, rho, peaks, 'FillGap', 5, 'MinLength', 7);
for k = 1:length(lines)
    myhoughline(cameraman, lines(k).rho, lines(k).theta);
    hold on;
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:, 1), xy(:, 2), 'LineWidth', 2, 'Color', 'green');
    hold off;
end
