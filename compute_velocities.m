%computes the theta derivatives of each vertex coordinate for the Jansen linkage
%INPUTS:
%vertex_coords: a column vector containing the (x,y) coordinates of every vertex
% these are assumed to be legal values that are roots of the error funcs!
%leg_params: a struct containing the parameters that describe the linkage
%theta: the current angle of the crank
%OUTPUTS:
%dVdtheta: a column vector containing the theta derivates of each vertex coord
function dVdtheta = compute_velocities(vertex_coords, leg_params, theta)
    % set jacobian
    link_length_wrap = @(vertex_coords) link_length_error_func(vertex_coords, leg_params);
    approx_jacob =  approximate_jacobian(link_length_wrap, vertex_coords);
    little_jacob = [eye(4), zeros(4,10)];
    full_jacob = [little_jacob; approx_jacob];

    %set zero vecotr
    b = zeros(length(vertex_coords), 1); 
    b(1) = -leg_params.crank_length*sin(theta); 
    b(2) = leg_params.crank_length*cos(theta);
    size(b)
    size(full_jacob)

    dVdtheta = full_jacob\b;
end