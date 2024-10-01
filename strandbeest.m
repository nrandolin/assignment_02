clear
clc
%% LEG PARAMS
%initialize leg_params structure
leg_params = struct();
%number of vertices in linkage
leg_params.num_vertices = 7;
%number of links in linkage
leg_params.num_linkages = 10;
%matrix relating links to vertices
leg_params.link_to_vertex_list = ...
[ 1, 3;... %link 1 adjacency
3, 4;... %link 2 adjacency
2, 3;... %link 3 adjacency
2, 4;... %link 4 adjacency
4, 5;... %link 5 adjacency
2, 6;... %link 6 adjacency
1, 6;... %link 7 adjacency
5, 6;... %link 8 adjacency
5, 7;... %link 9 adjacency
6, 7 ... %link 10 adjacency
];

leg_params.link_lengths = ...
[ 50.0,... %link 1 length
55.8,... %link 2 length
41.5,... %link 3 length
40.1,... %link 4 length
39.4,... %link 5 length
39.3,... %link 6 length
61.9,... %link 7 length
36.7,... %link 8 length
65.7,... %link 9 length
49.0 ... %link 10 length
];

%length of crank shaft
leg_params.crank_length = 15.0;
%fixed position coords of vertex 0
leg_params.vertex_pos0 = [0;0];
%fixed position coords of vertex 2
leg_params.vertex_pos2 = [-38.0;-7.8];


%column vector of initial guesses
%for each vertex location.
%in form: [x1;y1;x2;y2;...;xn;yn]
vertex_guess_coords = [...
[ 0; 50];... %vertex 1 guess
[ -50; 0];... %vertex 2 guess
[ -50; 50];... %vertex 3 guess
[-100; 0];... %vertex 4 guess
[-100; -50];... %vertex 5 guess
[ -50; -50];... %vertex 6 guess
[ -50; -100]... %vertex 7 guess
];

%% STRANDBEEST FIGURE

% initialize figure
% Download path for egg animation
mypath1 = 'C:\Users\ldao\Downloads\';
fname='strandbeest_animation.avi';
input_fname = [mypath1,fname];

% create a videowriter, which will write frames to the animation file
writerObj = VideoWriter(input_fname);

% must call open before writing any frames
open(writerObj);

fig1 = figure(1);
clf
hold on
leg_drawing = initialize_leg_drawing(leg_params);
velx = [];
vel_numx = [];
vely = [];
vel_numy = [];

theta = 0:pi/32:4*pi;
tip_x = zeros(length(theta), 1);
tip_y = zeros(length(theta), 1);
% draw strandbeest as crank shaft turns
count = 0;
for step = theta
    count =  count+1;
    vertex_coords_root = compute_coords(vertex_guess_coords, leg_params, step);
    tip_x(count) = vertex_coords_root(end-1);
    tip_y(count) = vertex_coords_root(end);
end
plot(tip_x, tip_y)
for step = theta
    vertex_coords_root = compute_coords(vertex_guess_coords, leg_params, step);
    dVdtheta = compute_velocities(vertex_coords_root, leg_params, step);
    dVdtheta_num = num_compute_velocities(vertex_guess_coords, leg_params, step);
    velx = [velx, dVdtheta(end-1)];
    vel_numx = [vel_numx, dVdtheta_num(end-1)];
    vely = [vely, dVdtheta(end)];
    vel_numy = [vel_numy, dVdtheta_num(end)];
    update_leg_drawing(vertex_coords_root, dVdtheta, dVdtheta_num, leg_drawing, leg_params, step)
    drawnow;
    current_frame = getframe(fig1);

    % write the frame to the video
    writeVideo(writerObj,current_frame)
end
close(writerObj);

plots_on = false;
if plots_on == true
    % plot the x velocity against theta for the two different velocity
    % computations
    figure(2)
    clf
    hold on
    plot(theta, velx, 'ro', 'MarkerSize', 7)
    plot(theta, vel_numx, '*b', 'MarkerSize',5)
    axis([0, 7, -50, 40,])
    xlabel("\theta (radians)")
    ylabel("Velocity (m/s)")
    legend("Linear Algebra Computation", "Numeric Computation")
    title("X Velocity vs Theta")
    
    % plot the y velocity against theta for the two different velocity
    % computations
    figure(3)
    clf
    hold on
    plot(step, vely, 'ro', 'MarkerSize', 7)
    plot(step, vel_numy, '*b', 'MarkerSize',5)
    xlabel("\theta (radians)")
    ylabel("Velocity (m/s)")
    legend("Linear Algebra Computation", "Numeric Computation")
    title("Y Velocity vs Theta")
end

