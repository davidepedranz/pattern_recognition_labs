function result = mask_matrix(matrix, center, radius, square)
    result = matrix;
    m = mean(matrix(:));
    center_y = center(1);
    center_x = center(2);
    for y = (center_y - radius) : (center_y + radius)
        for x = (center_x - radius) : (center_x + radius)
            value = normrnd(m, 1);
            if square
                result(y, x) = value;
            else
                if (x - center_x) ^ 2 + (y - center_y) ^ 2 < radius ^ 2
                    result(y, x) = value;
                end
            end
        end
    end
end

