clear variables
close all
clc

% Constantes Globais
m = 1;
K = 1;
alpha = -0.1;
tf = 10;

% Inicialização dos Vetores
arr_dt = [0.001 0.005 0.01 0.05 0.1 0.5];
x_n = zeros(1, length(arr_dt));

% Método Euler-Cromer

f = @(x) -K * (x + (2 * alpha * x^3)) / m;

for i = 1:length(arr_dt)
    dt = arr_dt(i);
    t = 0:dt:tf;
    x = ones(1, length(t));
    v = ones(1, length(t));
    for n = 1:length(t) - 1
        v(n + 1) = v(n) + f(x(n)) * dt;
        x(n + 1) = x(n) + v(n + 1) * dt;
    end
    x_n(i) = x(end);
end

plot(arr_dt, x_n);
p = polyfit(arr_dt, x_n, 1);
disp(p(2))


