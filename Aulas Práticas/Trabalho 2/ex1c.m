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
    A = [1 (k * dt / m); -dt 1];
    b = [v(n); x(n)];
    X = linsolve(A, b);
    v(n + 1) = X(1);
    x(n + 1) = X(2);
end

em = 0.5 * (m * v.^2 + k * x.^2);

figure(3)
subplot(3, 2, 1)
plot(t, x)
title("Euler-Implicito x/t")
subplot(3, 2, 2)
plot(t, v)
title("Euler-Implicito v/t")
subplot(3, 2, 3)
plot(x, v)
title("Euler-Implicito v/x")
subplot(3, 2, 4)
plot(t, em)
title("Euler-Implicito Em/t")
subplot(3, 2, 5)
x_an = cos(t);
plot(t, x_an)
title("Solução Analítica")