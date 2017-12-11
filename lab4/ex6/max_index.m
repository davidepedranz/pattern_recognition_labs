function [y, x] = max_index(matrix)
    [~, index] = max(matrix(:));
    [y, x] = ind2sub(size(matrix), index);
end

