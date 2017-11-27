clear; clf; close;

% input
mu = [3 4];
sigma = [1 0 ; 0 2];

% plot distribution
x = -10:0.1:10;
[X1,X2] = meshgrid(x, x);
F = reshape(mvnpdf([X1(:) X2(:)], mu, sigma), length(x), length(x));
fig = mesh(x, x, F);
xlabel('x1');
ylabel('x2');
zlabel('Probability Density');
title('Multivariante Normal Distribution');
saveas(fig, 'distribution', 'png');

points = [
    10 10;
    0 0;
    3 4;
    6 8;
];
distances = mahalanobis(points, mu, sigma);
fprintf('Distance of point (%i, %i) from center of distribution is %.5f\n', [points, distances]');
