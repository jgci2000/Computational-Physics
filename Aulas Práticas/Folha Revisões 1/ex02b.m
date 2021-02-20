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
options = optimset('Display', 'off', 'Tolx', 1e-10, 'TolFun', 1e-10);

% Método Crank-Nicolson

for i = 1:length(arr_dt)
    dt = arr_dt(i);
    t = 0:dt:tf;
    x = ones(1, length(t));
    v = ones(1, length(t));
    const = [dt / 2, K  * dt / (2 * m), 2 * alpha];
    for n = 1:length(t) - 1
        func = @(xv) frex01(xv, x(n), v(n), const);
        xv0 = [x(n), v(n)];
        aux = fsolve(func, xv0, options);
        x(n + 1) = aux(1);
        v(n + 1) = aux(2);
    end
    x_n(i) = x(end);
end

plot(arr_dt.^2, x_n);
p = polyfit(arr_dt.^2, x_n, 1);
disp(p(2))


