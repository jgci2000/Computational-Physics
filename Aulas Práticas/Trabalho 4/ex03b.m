clear variables
close all
clc

reltol = 3E-14;
abstol_1 = 1E-13;
abstol_2 = 1E-13;
abstol_3 = 1E-14;
options = odeset('RelTol', reltol, 'AbsTol', [abstol_1 abstol_2 abstol_3]);

t0 = 0;
tf = 250;
x0 = 1;
y0 = 2;
z0 = -1;
c = [2.2 3.5 4.1 5 5.2 5.7];

[t, sol1] = ode45(@f3, [t0 tf], [x0 y0 z0], options, c(1));
[t, sol2] = ode45(@f3, [t0 tf], [x0 y0 z0], options, c(2));
[t, sol3] = ode45(@f3, [t0 tf], [x0 y0 z0], options, c(3));
[t, sol4] = ode45(@f3, [t0 tf], [x0 y0 z0], options, c(4));
[t, sol5] = ode45(@f3, [t0 tf], [x0 y0 z0], options, c(5));
[t, sol6] = ode45(@f3, [t0 tf], [x0 y0 z0], options, c(6));



plot3(sol1(:, 1), sol1(:, 2), sol1(:, 3))
hold on
plot3(sol2(:, 1), sol2(:, 2), sol2(:, 3))
plot3(sol3(:, 1), sol3(:, 2), sol3(:, 3))
plot3(sol4(:, 1), sol4(:, 2), sol4(:, 3))
plot3(sol5(:, 1), sol5(:, 2), sol5(:, 3))
plot3(sol6(:, 1), sol6(:, 2), sol6(:, 3))