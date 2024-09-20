function test_numerical_jacobian()
    %number of tests to perform
    num_tests = 100;
    %iterate num_tests times
    for n = 1:num_tests
        %generate a matrix, A, of random size populated with random values
        A_width = randi([1,15])
        A_height = randi([1,15]);
        A = randn(A_height,A_width);
        %generate a vector, B, same height as A, random values inside
        B = randn(A_height,1);
        %create a new test function. Jacobian should just be A
        test_fun = @(X) A*X + B;
        X_guess = randn(A_width,1);
        %evaluate numerical Jacobian of test_fun
        %use whatever your function name was here!
        J = approximate_jacobian(test_fun,X_guess);
        %compare with Jacobian of A
        succeed = norm(J-A)/(A_width*A_height);
        %if J is not close to A, print fail.
        if succeed>1e-9
            disp("fail!");
        end
    end
end