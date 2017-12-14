clf; close all;
clear;

% load the image
tool_uint8 = imread('data/HeadTool0002.bmp');
tool_raw = im2double(tool_uint8);

% enhance the image
tool = adapthisteq(tool_raw);

% look for the circles
[centers, radii] = imfindcircles(tool, [20, 40], 'Method', 'TwoStage', 'Sensitivity', 0.9);

% plot the image with the circles
figure;
imshow(tool);
viscircles(centers, radii, 'EdgeColor', 'g');
saveas(gcf, 'all_circles', 'png');

% plot the top 2 circles
% NB: the outputs are already ordered by metric decrescent
figure;
imshow(tool);
viscircles(centers(1:2, :), radii(1:2), 'EdgeColor', 'r');
saveas(gcf, 'top_circles', 'png');
