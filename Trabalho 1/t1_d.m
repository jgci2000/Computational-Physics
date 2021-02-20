clear variables
close all
clc

% Preparação Rotina ode45
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
mu = 0.8;
F0 = 0;
w0 = 0;
dt = 0.001;

% Vetores
t = ti:dt:tf;
y = zeros(1, length(t));
v = zeros(1, length(t));
y(1) = yi;
v(1) = vi;

% Rotina ode45
[tOde, sol] = ode45(@func, [ti tf], [yi vi], options, m, K, alpha, mu, F0, w0);
yOde = sol(:, 1);
vOde = sol(:, 2);

% Preparação Método Runge-Kutta 4ª Ordem
fv = @(t, y, v) m^-1 * (mu * v * cos(v) - K *(y + alpha * y^3) + F0 * cos(w0 * t));
fy = @(v) v;

% Método Runge-Kutta 4ª ordem
for i = 1:length(t) - 1
    r1v = fv(t(i), y(i), v(i));
    r1y = fy(v(i));
    r2v = fv(t(i) + dt / 2, y(i) + r1y * dt / 2, v(i) + r1v * dt / 2);
    r2y = fy(v(i) + r1v * dt / 2);
    r3v = fv(t(i) + dt / 2, y(i) + r2y * dt / 2, v(i) + r2v * dt / 2);
    r3y = fy(v(i) + r2v * dt / 2);
    r4v = fv(t(i) + dt, y(i) + r3y * dt, v(i) + r3v * dt);
    r4y = fy(v(i) + r3v * dt);
    
    v(i + 1) = v(i) + (r1v + 2 * r2v + 2 * r3v + r4v) * dt / 6;
    y(i + 1) = y(i) + (r1y + 2 * r2y + 2 * r3y + r4y) * dt / 6;
end

% Graficos
figure(1)
subplot(2, 2, 1)
plot(tOde, yOde)
title("ode45 y(t)")
xlabel("t/s")
ylabel("y/m")
ylim([-2 2])

subplot(2, 2, 3)
plot(yOde, vOde)
title("ode45 v(y)")
xlabel("y/m")
ylabel("v/ms-1")
axis([-2 2 -2 2])

subplot(2, 2, 2)
plot(t, y)
title("RK4 y(t)")
xlabel("t/s")
ylabel("y/m")
ylim([-2 2])

subplot(2, 2, 4)
plot(y, v)
title("RK4 v(y)")
xlabel("y/m")
ylabel("v/ms-1")
axis([-2 2 -2 2])

% Gráficos erro
y = y(1:length(yOde));
erro = abs(y - yOde');
figure(2)
plot(tOde, log(erro))
