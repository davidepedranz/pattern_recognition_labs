function [y, x] = max_index(matrix)
    %%MAX_INDEX: find the coordinates of the maximum of a 2D matrix
    [~, index] = max(matrix(:));
    [y, x] = ind2sub(size(matrix), index);
end

