function [f_val, J] = test_function01(X)
    f_val = [X(1)^2 + X(2)^2 - 6 - X(3)^5;
        X(1)*X(3) + X(2) - 12;
        sin(X(1) + X(2) + X(3))];

    J = [2*X(1) 2*X(2) -5*X(3)^4;
        X(3) 1 X(1);
        cos(X(1) + X(2) + X(3)) cos(X(1) + X(2) + X(3)) cos(X(1) + X(2) + X(3))
        ];
end