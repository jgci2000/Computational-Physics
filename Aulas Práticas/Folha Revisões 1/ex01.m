clear variables
close all
clc

% Constantes Globais
m = 1;
K = 1;
alpha = -0.1;
dt = 0.01;
tf = 20;
t = 0:dt:tf;
N = length(t);

% Inicialização dos Vetores
x = zeros(1, N);
v = zeros(1, N);
x(1) = 1;
v(1) = 1;

% Método Crank-Nicolson
const = [dt / 2, K  * dt / (2 * m), 2 * alpha];
options = optimset('Display', 'off', 'Tolx', 1e-10, 'TolFun', 1e-10);


for n = 1:N - 1
    func = @(xv) frex01(xv, x(n), v(n), const);
    xv0 = [x(n), v(n)];
    aux = fsolve(func, xv0, options);
    x(n + 1) = aux(1);
    v(n + 1) = aux(2);
end

plot(t, x)
title("Position")
figure(2)
plot(t, v)
title("Velocity")
