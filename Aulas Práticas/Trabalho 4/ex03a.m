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
c = 2.2;

[t, sol] = ode45(@f3, [t0 tf], [x0 y0 z0], options, c);

plot3(sol(:, 1), sol(:, 2), sol(:, 3))

