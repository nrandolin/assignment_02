function x_next = newton_solver(fun, x0)
%Loop through until x is small
[f_val, J] = fun(x0);
x_next = x0;
    while abs(sum(f_val))> 1e-14 && abs(det(J*J')) > 1e-14
        %calculate next x
        x_next = x_next - J\f_val;
        %establish next y value
        [f_val, J]  = fun(x_next);        
    end
end