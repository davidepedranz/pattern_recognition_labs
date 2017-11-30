function plot_points(p_w1, mu_w1, sigma_w1, p_w2, mu_w2, sigma_w2, limit)
    x = limit(1):1:limit(2);
    y = x;
    [X, Y] = meshgrid(x,y);
    
    p_w1_x = reshape(mvnpdf([X(:) Y(:)], mu_w1, sigma_w1), size(X)) * p_w1;
    p_w2_x = reshape(mvnpdf([X(:) Y(:)], mu_w2, sigma_w2), size(X)) * p_w2;

    points = iff(p_w1_x > p_w2_x, 1, 2);
    gscatter(X(:), Y(:), points(:), 'bg', 'xo', 5);
end

