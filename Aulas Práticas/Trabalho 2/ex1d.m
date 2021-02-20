clearvars
close all
clc

dt = 0.01; tf = 20;
t = 0:dt:tf;

k = 1; m = 1;

x = zeros(1, length(t));
v = zeros(1, length(t));
x(1) = 1;
v(1) = 0;

for n = 1:length(t) - 1
    A = [1, (k * dt / (2 * m)); (-dt / 2), 1];
    b = [v(n) - (k * dt * x(n) / (2 * m)); dt * 2 * v(n) + x(n)];
    X = linsolve(A, b);
    v(n + 1) = X(1);
    x(n + 1) = X(2);
end

em = 0.5 * (m * v.^2 + k * x.^2);

figure(4)
subplot(3, 2, 1)
plot(t, x)
title("Cranck-Nicolson x/t")
subplot(3, 2, 2)
plot(t, v)
title("Cranck-Nicolson v/t")
subplot(3, 2, 3)
plot(x, v)
title("Cranck-Nicolson v/x")
subplot(3, 2, 4)
plot(t, em)
title("Cranck-Nicolson Em/t")
subplot(3, 2, 5)
x_an = cos(t);
plot(t, x_an)
title("Solução Analítica")