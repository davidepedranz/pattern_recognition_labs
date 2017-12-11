function result = remove_second_max(matrix, radius, square)
    
    % mask the first maximum
    [index_max_y, index_max_x] = max_index(matrix);
    matrix_no_max = mask_matrix(matrix, [index_max_y, index_max_x], radius, square);
    
    % mask the second maximum
    [index_y, index_x] = max_index(matrix_no_max);
    result = mask_matrix(matrix, [index_y, index_x], radius, square);
end

