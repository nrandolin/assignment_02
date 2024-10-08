%Updates the plot objects that visualize the leg linkage
%for the current leg configuration
%INPUTS:
%vertex_coords_root: a column vector containing the (x,y) coordinates of every vertex
%leg_drawing: a struct containing all the plotting objects for the linkage
% leg_drawing.linkages is a cell array, where each element corresponds
% to a plot of a single link (excluding the crank)
% leg_drawing.crank is a plot of the crank link
% leg_drawing.vertices is a cell array, where each element corresponds
% to a plot of one of the vertices in the linkage
function update_leg_drawing(vertex_coords, dVdtheta, dVdtheta_num, leg_drawing, leg_params, theta)
    %iterate through each link, and update corresponding link plot
    axis equal; axis([-120 50 -120 50])

    for linkage_index = 1:leg_params.num_linkages
        %linkage_index is the label of the current link
        va = leg_params.link_to_vertex_list(linkage_index, 1);
        vb = leg_params.link_to_vertex_list(linkage_index, 2);
        xa = vertex_coords(2*va-1);
        ya = vertex_coords(2*va);
        xb = vertex_coords(2*vb-1);
        yb = vertex_coords(2*vb);
        %line_x and line_y should both be two element arrays containing
        %the x and y coordinates of the line segment describing the current link
        line_x = [xa, xb];
        line_y = [ya, yb];
        set(leg_drawing.linkages{linkage_index},'xdata',line_x,'ydata',line_y);
    end
    %iterate through each vertex, and update corresponding vertex plot
    for vertex_index = 1:leg_params.num_vertices
        %vertex_index is the label of the current vertex
        xa = vertex_coords(2*vertex_index-1);
        ya = vertex_coords(2*vertex_index);
        %dot_x and dot_y should both be scalars
        %specifically the x and y coordinates of the corresponding vertex
        dot_x = xa;
        dot_y = ya;
        set(leg_drawing.vertices{vertex_index},'xdata',dot_x,'ydata',dot_y);
    end
    %your code here
    %crank_x and crank_y should both be two element arrays
    %containing the x and y coordinates of the line segment describing the crank
    crank_x = [0, vertex_coords(1)];
    crank_y = [0, vertex_coords(2)];
    set(leg_drawing.crank,'xdata',crank_x,'ydata',crank_y, 'Color', 'b');

    % plot tip velocity vector
    hold on
    x_point = vertex_coords(end-1);
    y_point = vertex_coords(end);
    x_delta = dVdtheta(end-1);
    y_delta = dVdtheta(end);
    unit_velx = x_delta/sqrt(x_delta^2 + y_delta ^2);
    unit_vely = y_delta/sqrt(x_delta^2 + y_delta ^2);
    scale = 10;
    set(leg_drawing.tip_vector, 'xdata',[x_point, x_point + unit_velx*scale], 'ydata', [y_point, y_point+unit_vely*scale]);
    % quiver(x_point, y_point, x_point + x_delta, y_point + y_delta)
    % quiver(x_point, y_point, x_point + dVdtheta_num(end-1), y_point + dVdtheta_num(end))
    %trace crank path
    set(leg_drawing.crank_point, 'xdata',vertex_coords(1), 'ydata', vertex_coords(2), 'marker', 'o', 'MarkerFaceColor', 'b', 'MarkerSize', 3, 'MarkerEdgeColor', 'b')

    %trace leg path
    hold on
    

end