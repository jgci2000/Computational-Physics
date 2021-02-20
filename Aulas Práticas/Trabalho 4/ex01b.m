clear variables
close all
clc

h = [0.1 0.82 0.5 1];

tf = 5000;
dt = h(2); %Escolher h 1 = 0.1; 2 = 0.82; 3 = 0.5; 4 = 1
t = 0:dt:tf;

x = zeros(1, length(t));
y = zeros(1, length(t));
x(1) = 0.01;
y(1) = 0.01;

fx = @(y) y;
fy = @(y, x) (1 - x^2 - y^2) * y - x;

for n = 1:length(t) - 1
    r1x = fx(y(n));
    r1y = fy(x(n), y(n));
    r2x = fx(y(n) + r1y * dt * 0.5);
    r2y = fy(y(n) + r1y * dt * 0.5, x(n) + r1x * dt * 0.5);
    r3x = fx(y(n) + r2y * dt * 0.5);
    r3y = fy(y(n) + r2y * dt * 0.5, x(n) + r2x * dt * 0.5);
    r4x = fx(y(n) + r3y * dt);
    r4y = fy(y(n) + r3y * dt, x(n) + r3x * dt);
    
    x(n + 1) = x(n) + (dt / 6) * (r1x + 2 * r2x + 2 * r3x + r4x);
    y(n + 1) = y(n) + (dt / 6) * (r1y + 2 * r2y + 2 * r3y + r4y);
end

plot(x, y, '.')

% subplot(2, 2, 1)
% plot(x, y, '.')
% subplot(2, 2, 2)
% plot(x, t, '.')
% subplot(2, 2, 3)
% plot(y, t, '.')