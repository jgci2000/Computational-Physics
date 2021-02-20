clear variables
close all
clc

% Constantes para rotina ode45
reltol = 3E-14;
abstol_1 = 1E-13;
abstol_2 = 1E-13;
options = odeset('RelTol',reltol,'AbsTol',[abstol_1 abstol_2]);
ti = 0;
tf = 150;
yi = 1.5;
vi = 0;

% Constantes globais
m = 1;
K = 1;
alpha = 0.2;
F0 = 0;
w0 = 0;

% Vetores
mu = 0:0.05:0.8;
T = zeros(1, length(mu));
A = zeros(1, length(mu));

% Rotina ode45
for i = 1:length(mu)
    [t, sol] = ode45(@func, [ti tf], [yi vi], options, m, K, alpha, mu(i), F0, w0);
    y = sol(:, 1);
    c = 0;
    for n = 2:length(y) - 1
        if y(n - 1) <= y(n) && y(n) >= y(n + 1)
            c = c + 1;
            idx(c) = n;
        end
    end
    [tMax1, yMax1] = lagr(t(idx(3) - 1:idx(3) + 1), y(idx(3) - 1:idx(3) + 1));
    [tMax2, yMax2] = lagr(t(idx(4) - 1:idx(4) + 1), y(idx(4) - 1:idx(4) + 1));
    T(i) = tMax2 - tMax1;
    A(i) = yMax1;
    clear sol t v y tMax1 yMax1 tMax2 yMax2 idx c
end
% Graficos
subplot(2, 1, 1)
plot(mu, T, 'o-')
title("T(mu)")
xlabel("mu")
ylabel("T")

subplot(2, 1, 2)
plot(mu, A, 'o-')
title("A(mu)")
xlabel("mu")
ylabel("A")

