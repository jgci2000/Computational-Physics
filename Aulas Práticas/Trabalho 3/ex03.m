clear all
close all
clc

m = 1;
k = 16;

reltol = 3E-14;
abstol_1 = 1E-13;
abstol_2 = 1E-13;
t0 = 0;
tf = 10;
x0 = 1;
v0 = 0;

options = odeset('RelTol',reltol,'AbsTol',[abstol_1 abstol_2]);
[t,sol] = ode45(@f3,[t0 tf],[x0 v0],options);

em = 0.5*(m * sol(:, 2).^2 + k * sol(:, 1).^2);

plot(t, sol(:, 1))
hold on
plot(t, sol(:, 2))
plot(t, em)