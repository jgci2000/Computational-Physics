clear variables
close all
clc

m = 1.5;
k = 2;
K = k / m;

reltol = 3E-14;
abstol_1 = 1E-13;
abstol_2 = 1E-13;
options = odeset('RelTol',reltol,'AbsTol',[abstol_1 abstol_2]);
xi = 1.9;
vi = 0;
ti = 0;
tf = 20;
xf = -1.5;
Nshooting = 10;

guess(1) = -0.1;
guess(2) = -0.2;
tol = 1E-12;

for i = 1:Nshooting
    A = [];
    alpha = guess(i);
    [t, sol] = ode45(@func, [ti tf], [xi vi], options, m ,k, );
    x = sol(:, 1);
    
    counter = 0;
    for j = 2:length(t) - 1
        if (x(j) <= x(j - 1) && x(j) <= x(j + 1))
            counter = counter + 1;
            A(counter) = x(j);
        end
    end
    result(i) = min(A);
    
    plot(t, x)
    pause(0.5);
    
    if i > 1
        m = (result(i) - result(i - 1)) / (guess(i) - guess(i - 1));
        b = result(i) - m * guess(i);
        guess(i + 1) = guess(i) + (xf - result(i)) / m;
        if abs(guess(i + 1) - guess(i)) < tol
            alpha = guess(i)
            break
        end
    end
end
