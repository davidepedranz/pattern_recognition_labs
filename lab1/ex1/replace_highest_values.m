% replace the entries in the matrix with the highest values with zero
function [new_matrix] = replace_highest_values(original_matrix)
    new_matrix = original_matrix;
    max_value = max(new_matrix(:));
    new_matrix(new_matrix == max_value) = 0;
end