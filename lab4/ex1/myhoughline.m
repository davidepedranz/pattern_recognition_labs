function myhoughline(image, rho, theta_degrees, plot_image)
   
    % optional parameter to plot the image
    % by default, plot both the image and the line
    switch nargin
        case 3
            plot_image = true;
    end
    
    % NB: the hough function express theta in degrees...
    % we need to convert it to radiants to use the Matlab sin and cos
    theta_radians = deg2rad(theta_degrees);
    
    % normal polar coordinates express the angles in anti-clockwise direction
    % in our system, angles are expressed clockwise direction
    theta = - theta_radians;
    
    % extract dimension of the image... used later
    [pixels_y, pixels_x] = size(image);
    
    % handle vertical lines
    if theta == 0
        % this is a vertical line... x is fixed, y goes through all the image
        y = 1:pixels_y;
        x = ones(size(y)) * rho;
    else
        % we only need to plot the line on the image... so it makes sense to
        % only use x from 0 (the origin) to the number of pixels on the x axis
        x = 1:pixels_x;
        
        % compute the y for each given x
        normal_y = (rho - x * cos(theta)) / sin(theta);
        
        % normal polar coordinates have the origin in the bottom-left corner
        % our system has the origin in the top-left corner and the y-axis is flipped 
        y = - normal_y;
    end
    
    % plot the image
    if plot_image
        figure;
        imshow(image);
    end
    
    % plot the line
    hold on;
    plot(x, y, 'r', 'LineWidth', 1);
    hold off;
end
