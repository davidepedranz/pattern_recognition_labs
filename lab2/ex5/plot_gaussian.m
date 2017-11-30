function plot_gaussian(mu, sigma, limit)
    x = limit(1):.1:limit(2);
    y = x;

    [X, Y] = meshgrid(x,y);
    Z = mvnpdf([X(:) Y(:)], mu, sigma);
    Z = reshape(Z, size(X));
    contour(X, Y, Z);
end

