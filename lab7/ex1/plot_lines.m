function plot_lines(X, threshold)
    samples = size(X, 1);
    box on;
    hold on;
    edges = pdist2(X, X, 'euclidean')  < threshold;
    for i = 1 : samples
        for j = i + 1 : samples
            if edges(i, j)
                a = X(i, :);
                b = X(j, :);
                line([a(1), b(1)], [a(2), b(2)], 'color', 'k');
            end
        end
    end
end
