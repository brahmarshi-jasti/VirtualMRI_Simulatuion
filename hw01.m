% Custom function to generate the phantom image using modified_coords
function phantom_modified = generate_modified_phantom(img_size, modified_coords)

    % Initialize the phantom matrix
    phantom_modified = zeros(img_size);

    % Create X and Y values for the grid
    [x, y] = meshgrid(linspace(-1, 1, img_size), linspace(-1, 1, img_size));

    for i = 1:size(modified_coords, 1)
        amplitude = modified_coords(i, 1);
        center_x = modified_coords(i, 2);
        center_y = modified_coords(i, 3);
        semi_major_axis = modified_coords(i, 4);
        semi_minor_axis = modified_coords(i, 5);
        rotation_angle = modified_coords(i, 6);

        % Rotate coordinates
        xp = (x - center_x) * cos(rotation_angle) + (y - center_y) * sin(rotation_angle);
        yp = -(x - center_x) * sin(rotation_angle) + (y - center_y) * cos(rotation_angle);

        % Ellipse equation to check if points are inside
        is_inside = (xp.^2 / semi_major_axis^2 + yp.^2 / semi_minor_axis^2) <= 1;

        % Assign amplitude to the phantom where the ellipse exists
        phantom_modified(is_inside) = amplitude;
    end
end



overlapped_coordinates = [
    1, 0, 0, 0.5, 0.7, 0;   
    0.25, 0, 0.019, 0.48, 0.66, 0;  
    0.4, 0, -0.28, 0.17, 0.22, 0;  
    0.1, -0.18, 0.01, 0.15, 0.33, -0.3141592653589793;  
    0.1, 0.18, 0, 0.08, 0.21, 0.20943951023931953;  
    0.4, 0, -0.05, 0.035, 0.035, 0;  
    0.4, 0, 0.1, 0.035, 0.035, 0;  
    0.4, -0.05, 0.45, 0.025, 0.016, 0;  
    0.4, 0, 0.45, 0.023, 0.022, 0;  
    0.4, 0.05, 0.45, 0.02, 0.038, 0
];

modified_coordinates = [
    1, 0, 0, 0.5, 0.7, 0;  
    0.25, 0, 0.019, 0.48, 0.66, 0;  
    0.4, 0, -0.28, 0.12, 0.16, 0;  
    0.1, -0.18, 0.05, 0.12, 0.29, -0.3141592653589793;  
    0.1, 0.18, 0, 0.08, 0.21, 0.20943951023931953;  
    0.4, 0, -0.05, 0.03, 0.03, 0;  
    0.4, 0, 0.1, 0.03, 0.03, 0;  
    0.4, -0.05, 0.45, 0.019, 0.019, 0;  
    0.4, 0, 0.45, 0.019, 0.019, 0;  
    0.4, 0.05, 0.45, 0.021, 0.04, 0;
    
];

% Image size
img_size = 1024;

phantom_modified_overlap = generate_modified_phantom(img_size, overlapped_coordinates);
% % % 
% % % % 
figure;
imshow(phantom_modified_overlap, []);
title('Overlapped Phantom');
imwrite(phantom_modified_overlap, 'phantom_modified_overlap.png');



phantom_modified_no_overlap = generate_modified_phantom(img_size, modified_coordinates);
% % % 
% % % %
figure;
imshow(phantom_modified_no_overlap, []);
 title('Modified Phantom without overlap');
 imwrite(phantom_modified_no_overlap, 'phantom_modified_no_overlap.png');


modified_coords_with_circles = [
    modified_coordinates;  % Original no overlap coordinates
    0.3, -0.8, 0.8, 0.1, 0.1, 0;  % Circle 1 outside the brain
    0.3, 0.8, 0.8, 0.1, 0.1, 0    % Circle 2 outside the brain
];

phantom_with_circles = generate_modified_phantom(img_size, modified_coords_with_circles);

 % Display the phantom with additional circular structures
figure;
imshow(phantom_with_circles, []);
title('Modified Phantom with Two Circular Structures Outside');
imwrite(phantom_with_circles, 'phantom_with_circles.png');




ellipses_concentric = [
    1, 0, 0, 0.4, 0.4, 1;   % Outer circle
    0.5, 0, 0, 0.3, 0.3, 0.6;  % Middle circle
     0.3, 0, 0, 0.2, 0.2, 0.3;  % Inner circle
 ];
 
% Generate and display the concentric circle phantom
phantom_concentric = generate_modified_phantom(img_size, ellipses_concentric);
figure, imshow(phantom_concentric, []);
 title('Phantom with Three Concentric Circles');

 imwrite(phantom_concentric, 'phantom_image_3_concentric.png');
