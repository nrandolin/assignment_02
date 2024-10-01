%computes the theta derivatives of each vertex coordinate for the Jansen linkage
%INPUTS:
%vertex_coords: a column vector containing the (x,y) coordinates of every vertex
% these are assumed to be legal values that are roots of the error funcs!
%leg_params: a struct containing the parameters that describe the linkage
%theta: the current angle of the crank
%OUTPUTS:
%dVdtheta: a column vector containing the theta derivates of each vertex coord
function dVdtheta_num = num_compute_velocities(vertex_coords, leg_params, theta)
    vertex_coords_num = @(theta) compute_coords(vertex_coords, leg_params, theta);
    dVdtheta_num =  approximate_jacobian(vertex_coords_num, theta);
end
