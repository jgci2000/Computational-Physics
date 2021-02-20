clear variables
close all
clc

reltol = 3E-14;
abstol_1 = 1E-13;
abstol_2 = 1E-13;
t0 = 0;
tf = 250;
F0_a = [1 5];

x0 = 2;
v0 = 0;
epsilon = 0.3;
F0 = F0_a(1); %Escolher F 1 = 1; 2 = 5

options = odeset('RelTol', reltol, 'AbsTol', [abstol_1 abstol_2]);
[t,sol] = ode45(@f2b, [t0 tf], [x0 v0], options, epsilon, F0);

plot(sol(:, 1), sol(:, 2), '-')