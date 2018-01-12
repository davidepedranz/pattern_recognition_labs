function [prototypes] = seqBatchNG(X, n, epochs, xdim, ydim, draw_plot)
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

    % extract the dimension of the dataset
    [n_examples, dim] = size(X);

    % initialize prototypes to small values
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
        
        % difference for vectors is initially zero
        D_prototypes = zeros(n, dim);
        
        % the same holds for the quotients
        D_prototypes_av = zeros(n, 1);
        
        % consider all points at once for the batch update
        for j = 1 : n_examples 

            % sample vector
            x = X(j, :);

            % neighborhood ranking
            distances = pdist2(prototypes, x, 'squaredeuclidean');
            ranking = tiedrank(distances) - 1;     
            
            % accumulate update
            tmp = e .^ (-ranking / lambda(i));
            D_prototypes = D_prototypes + (tmp * x);
            D_prototypes_av = D_prototypes_av + tmp;
        end
        
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
