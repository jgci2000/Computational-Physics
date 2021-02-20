clear variables
close all
clc

reltol = 3E-14;
abstol_1 = 1E-13;
abstol_2 = 1E-13;
t0 = 0;
tf = 250;
x0_a = [1 4 7];
v0_a = [0 3 5];
ep_a = [0.1 1];

x0 = x0_a(1); %Escolher x0 1 = 1; 2 = 4; 3 = 7
v0 = v0_a(1); %Escolher v0 1 = 0; 2 = 3; 3 = 5
epsilon = ep_a(1); %Escolher epsilon 1 = 0.1; 2 = 1

options = odeset('RelTol', reltol, 'AbsTol', [abstol_1 abstol_2]);
[t,sol] = ode45(@f2a, [t0 tf], [x0 v0], options, epsilon);

plot(sol(:, 1), sol(:, 2), '.')