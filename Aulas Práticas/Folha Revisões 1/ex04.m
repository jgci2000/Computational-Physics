clear variables
close all
clc

% Constantes Globais
reltol = 3E-14;
abstol_1 = 1E-13;
abstol_2 = 1E-13;
w0 = 1;
q = 1 / 2;
wd = 2 / 3;
theta0 = 0.2;
theta_dot0 = 0;
Fd = [0 0.1 1.2];

% Tempo
t0 = 0;
tf = 100;

% Rotina ode45
options = odeset('RelTol', reltol, 'AbsTol', [abstol_1 abstol_2]);

[t, sol1] = ode45(@frex04, [t0 tf], [theta0 theta_dot0], options, w0, q, wd, Fd(1));
[t, sol2] = ode45(@frex04, [t0 tf], [theta0 theta_dot0], options, w0, q, wd, Fd(2));
[t, sol3] = ode45(@frex04, [t0 tf], [theta0 theta_dot0], options, w0, q, wd, Fd(3));

figure(1)
plot(cos(sol1(:, 1)), sin(sol1(:, 2)))
title("Fd = 0")
figure(2)
plot(cos(sol2(:, 1)), sin(sol2(:, 2)))
title("Fd = 0.1")
figure(3)
plot(cos(sol3(:, 1)), sin(sol3(:, 2)))
title("Fd = 1.2")