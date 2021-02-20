clear all
close all
clc


k = 16;
m = 1;

tf = 12000;
dt = 0.1;
t = 0:dt:tf;

x_euler = zeros(1, length(t));
v_euler = zeros(1, length(t));
x_euler(1) = 1;

for i = 1:length(t) - 1
    v_euler(i + 1) = v_euler(i) + (-k / m) * x_euler(i) * dt;
    x_euler(i + 1) = x_euler(i) + v_euler(i) * dt;
end

em_euler = 0.5*(m * v_euler.^2 + k * x_euler.^2);

x_runge = zeros(1, length(t));
v_runge = zeros(1, length(t));
x_runge(1) = 1;

fv = @(x) -k * x / m;
fx = @(v) v;

for i = 1:length(t) - 1
    r1v = fv(x_runge(i));
    r1x = fx(v_runge(i));
    r2v = fv(x_runge(i) + r1x * dt / 2);
    r2x = fx(v_runge(i) + r1v * dt / 2);
    
    v_runge(i + 1) = v_runge(i) + r2v * dt;
    x_runge(i + 1) = x_runge(i) + r2x * dt;
end

em_runge = 0.5*(m * v_runge.^2 + k * x_runge.^2);

subplot(2, 3, 1)
plot(t, x_euler)
title("Euler")

subplot(2, 3, 2)
plot(t, x_runge)
title("Runge-Kutta")

subplot(2, 3, 3)
plot(t, cos(sqrt(k / m) * t))
title("Analitica")

subplot(2, 3, 4)
plot(t, em_euler)
title("Euler EM")

subplot(2, 3, 5)
plot(t, em_runge)
title("Runge-Kutta EM")
