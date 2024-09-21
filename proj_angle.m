x_val = multi_newton_solver(@target_traj, pi/3, true)
V_p = projectile_traj(x_val, 6)
run_simulation(x_val,20)