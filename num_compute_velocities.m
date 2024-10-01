function dVdtheta_num = num_compute_velocities(vertex_coords, leg_params, theta)
%     vertex_coords_num = @(theta) compute_coords(vertex_coords, leg_params, theta);
%     approx_jacob =  approximate_jacobian(vertex_coords_num, vertex_coords);
% 
%     %set zero vector
%     b = zeros(length(vertex_coords), 1); 
%     b(1) = -leg_params.crank_length*sin(theta); 
%     b(2) = leg_params.crank_length*cos(theta);
%     b
%     approx_jacob
    

    % link_length_wrap = @(vertex_coords) link_length_error_func(vertex_coords, leg_params);
    % approx_jacob =  approximate_jacobian(link_length_wrap, vertex_coords);
    % little_jacob = [eye(4), zeros(4,10)];
    % full_jacob = [little_jacob; approx_jacob];
    % 
    % delta_theta = pi/32;
    % b = vertex_coords_num(theta+delta_theta);

    vertex_coords_num = @(theta) compute_coords(vertex_coords, leg_params, theta);
    dVdtheta_num =  approximate_jacobian(vertex_coords_num, theta);


end
