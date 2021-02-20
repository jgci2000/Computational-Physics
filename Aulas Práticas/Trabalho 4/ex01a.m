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


for n = 1:length(t) - 1
    x(n + 1) = x(n) + dt * y(n);
    y(n + 1) = y(n) + dt * ((1 - x(n)^2 - y(n)^2) * y(n) - x(n));
end

plot(x, y, '.')

% subplot(2, 2, 1)
% plot(x, y, '.')
% subplot(2, 2, 2)
% plot(x, t, '.')
% subplot(2, 2, 3)
% plot(y, t, '.')