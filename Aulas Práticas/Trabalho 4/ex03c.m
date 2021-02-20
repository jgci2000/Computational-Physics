clear variables
close all
clc

reltol = 3E-14;
abstol_1 = 1E-13;
abstol_2 = 1E-13;
abstol_3 = 1E-14;
options = odeset('RelTol', reltol, 'AbsTol', [abstol_1 abstol_2 abstol_3]);

t0 = 0;
dt = 0.001;
tf = 250;
c_a = [2.2 5];

x0_1 = 1;
y0_1 = 2;
z0_1 = -1;

x0_2 = 1 + 10E-3;
y0_2 = 2 + 10E-3;
z0_2 = -1 + 10E-3;

c = c_a(1); %Escolher c 1 = 2.2; 2 = 5

[~, sol1] = ode45(@f3, t0:dt:tf, [x0_1 y0_1 z0_1], options, c);
[~, sol2] = ode45(@f3, t0:dt:tf, [x0_2 y0_2 z0_2], options, c);

dr_mod = (sol2(:, 1) - sol1(:, 1)).^2 + (sol2(:, 2) - sol1(:, 2)).^2 + (sol2(:, 3) - sol1(:, 3)).^2;

plot(t0:dt:tf, dr_mod);
