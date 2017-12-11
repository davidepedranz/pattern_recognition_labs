function [accumulator, thetas, rhos] = myhough(edges)

    % take all possible angles
    thetas = -90:1:89;
    assert(length(thetas) == 180);
    
    % the max distance of a line from the origin is the length of
    % diagonal of the image
    max_rho = floor(max(size(edges)) * sqrt(2));
    rhos = -max_rho:1:max_rho;
    
    % initialize the accumulator
    len_rhos = length(rhos);
    len_thetas = length(thetas);
    accumulator = zeros(len_rhos, len_thetas);

    % iterate on each foreground pixel
    [len_y, len_x] = size(edges); 
    for x = 1:len_x
        for y = 1:len_y
            if edges(y, x) == 1
                theta_radiants = deg2rad(thetas);
                current_rhos = floor(x * cos(theta_radiants) + y * sin(theta_radiants));
                
                % for each point of the line, we look for the index in the
                % rhos and theths arrays (+1 is because Matlab indexes start at 1)
                rhos_indexes = current_rhos + max_rho + 1;
                for i = 1:length(rhos_indexes)
                    rho_index = rhos_indexes(i);
                    accumulator(rho_index, i) = accumulator(rho_index, i) + 1;
                end
            end
        end
    end
end