function distances = mahalanobis(points, mu, sigma)
    %%MAHALANOBIS Compute the Mahalanobis distance of a matrix of 
    %% observations (one observation per row) from the center of a
    %% multinomial normal distribution ~ N(mu, sigma).
    distances = sqrt(diag((points - mu) * inv(sigma) * (points - mu)'));
end

