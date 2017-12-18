function plot_result(grid_points, grid_labels, X, y, prototypes, prototypes_classes, n_prototypes, mrk, colors, colors_1, colors_2)
    
    % plot the classification boundary
    figure;
    gscatter(grid_points(:, 1), grid_points(:, 2), grid_labels, colors_2);
    
    % plot the prototypes
    hold on;
    h = gscatter(prototypes(:, 1), prototypes(:, 2), prototypes_classes, colors, mrk, 12, 'off');
    hold off;
    for n = 1 : length(h)
        set(h(n), 'MarkerFaceColor', colors(n, :));
    end
    
    % plot the dataset
    hold on;
    gscatter(X(:, 1), X(:, 2), y, colors_1, '^o');
    hold off;
    title(sprintf('Classification using %s prototypes', mat2str(n_prototypes)));
    xlabel('Feature 1');
    ylabel('Feature 2');
    xlim([floor(min(X(:, 1))), ceil(max(X(:, 1)))]);
    ylim([floor(min(X(:, 2))), ceil(max(X(:, 2)))]);
    legend('Location', 'northwest')
end
