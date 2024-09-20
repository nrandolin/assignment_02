function J = approximate_jacobian(fun,x)
    ej = zeros(length(x), 1);
    h = 1e-6;
    J = zeros(length(x), length(x))
    for i = 1:length(ej)
        ej(i) = 1;
        partial = (fun(x+h.*ej) - fun(x-h.*ej))/(2.*h)
        J(:, i) = (fun(x+h*ej) - fun(x-h*ej))/(2*h);
        ej(i) = 0;
    end
       
end