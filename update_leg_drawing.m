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
function update_leg_drawing(vertex_coords, leg_drawing, leg_params)
    %iterate through each link, and update corresponding link plot
    axis equal;
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
        va = leg_params.link_to_vertex_list(vertex_index, 1);
        vb = leg_params.link_to_vertex_list(vertex_index, 2);
        xa = vertex_coords(2*va-1);
        ya = vertex_coords(2*va);
        xb = vertex_coords(2*vb-1);
        yb = vertex_coords(2*vb);
        %dot_x and dot_y should both be scalars
        %specifically the x and y coordinates of the corresponding vertex
        dot_x = xa;
        dot_y = ya;
        set(leg_drawing.vertices{vertex_index},'xdata',dot_x,'ydata',dot_y);
    end
    %your code here
    %crank_x and crank_y should both be two element arrays
    %containing the x and y coordinates of the line segment describing the crank
    crank_x = [vertex_coords(11), vertex_coords(13)]
    crank_y = [vertex_coords(12), vertex_coords(14)]
    set(leg_drawing.crank,'xdata',crank_x,'ydata',crank_y, "Color", "green");
end