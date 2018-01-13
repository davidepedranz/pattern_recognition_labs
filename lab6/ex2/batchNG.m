function [prototypes] = batchNG(X, n, epochs, xdim, ydim, draw_plot)
    % Batch Neural Gas
    %   X contains data,
    %   n is the number of clusters,
    %   epoch the number of iterations,
    %   xdim and ydim are the dimensions to be plotted, default xdim=1, ydim=2
    %   draw_plot tells if the function should plot intermediate results

    % check the number of input arguments
    narginchk(3, 6);
    if (nargin < 4)
        xdim = 1;
        ydim = 2;
        draw_plot = true;
    end

    % initialize prototypes to small values
    % the following code works, but for this exercise we force the
    % initialization to the given centroids
    % [~, dim] = size(X);
    % prototypes = rand(n, dim) - 0.5;
    % for i = 1 : size(prototypes, 1)
    %     prototypes(i, :) = prototypes(i, :) / norm(prototypes(i, :));
    % end

    % load prototypes from the file
    prototypes = importdata('data/clusterCentroids.mat');

    % initial neighborhood value
    lambda0 = n / 2;

    % lambda
    % note: the lecture slides refer to this parameter as sigma^2
    lambda = lambda0 * ((0.01 / lambda0) .^ ((0 : (epochs - 1)) / epochs));
    
    % compute the value of number e
    e = exp(1);
    
    % training loop...
    for i = 1 : epochs
        
        % print the progress
        fprintf(1, '%d / %d \r', i, epochs);
        
        % please note that this is the vectorized implementation
        % of batch neural gas...
        
        % neighborhood ranking
        distances = pdist2(prototypes, X, 'squaredeuclidean');
        ranking = tiedrank(distances) - 1;
        
        % compute the updates for each single example
        tmp = e .^ (-ranking / lambda(i));
        D_prototypes = tmp * X;
        D_prototypes_av = sum(tmp, 2);
        
        % update
        prototypes = D_prototypes ./ D_prototypes_av;
        
        % plot the changes
        if draw_plot
            
            % replot the dataset
            hold off;
            plot(X(:, xdim), X(:, ydim), 'bo', 'markersize', 3);
            hold on;
            
            % plot the new prototypes
            plot(prototypes(:, xdim), prototypes(:, ydim), 'r.', ...
                'markersize', 10, 'linewidth', 3);
            
            % plot decision boundaries
            voronoi(prototypes(:, xdim), prototypes(:, ydim));

            % force the update of the drawing
            drawnow;
        end
    end
end
