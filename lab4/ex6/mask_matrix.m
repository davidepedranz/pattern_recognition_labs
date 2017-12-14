function result = mask_matrix(matrix, center, radius, square)
    %%MASK_MATRIX: replace the point in the matrix with random noice for an
    %%area defined by the center and the radius. If square is true, then
    %%use a square instead of a circle.
    
    % copy the matrix not to override the original one
    result = matrix;
    
    % compute the mean... used later to generate the random noise
    m = mean(matrix(:));
    
    % extract the coordinates of the center
    center_y = center(1);
    center_x = center(2);
    
    % iterate on a square centered in the center and with side of 2*radius
    for y = (center_y - radius) : (center_y + radius)
        for x = (center_x - radius) : (center_x + radius)
            
            % generate some random white noise
            value = normrnd(m, 1);
            
            % use a square shape => mask every point
            if square
                result(y, x) = value;
            else
                % mask only the points contained in the circle
                if (x - center_x) ^ 2 + (y - center_y) ^ 2 < radius ^ 2
                    result(y, x) = value;
                end
            end
        end
    end
end

