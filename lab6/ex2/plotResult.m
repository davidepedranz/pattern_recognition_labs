function plotResult(X, prototypes)

    % plot the dataset
    plot(X(:, 1), X(:, 2), 'bo', 'markersize', 2);
    xlabel('Dimension 1');
    ylabel('Dimension 2');

    % plot the new prototypes
    hold on;
    plot(prototypes(:, 1), prototypes(:, 2), 'r.', ...
        'markersize', 10, 'linewidth', 3);

    % plot decision boundaries
    voronoi(prototypes(:, 1), prototypes(:, 2));
    hold off;
end
