%% TEST

% wrapper
theta_x = traj(pi/3)
run_simulation(theta_x,6)

function x_point = wrapper_x(t)
    V_t = target_traj(t);
    x_point = V_t(1);
end

function y_point = wrapper_y(t)
    V_t = target_traj(t);
    y_point = V_t(2);
end

function [theta_x, theta_y] = traj(theta_guess)
    V_p = @(t) projectile_traj(t, theta_guess);
    wrapper_x_2 = @(t) wrapper_x(t) - projectile_traj(t, theta_guess);
    wrapper_y_2 = @(t) wrapper_y(t) - V_p(2);

    theta_x = multi_newton_solver(wrapper_x_2, theta_guess, true);
    theta_y = multi_newton_solver(wrapper_y_2, theta_guess, true);
end

% x_val = multi_newton_solver(@target_traj, pi/3, true)
% V_p = projectile_traj(x_val, 6)
% run_simulation(x_val,6)