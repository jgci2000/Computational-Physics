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
mu = 0.8;

% Vetores
F0 = [0 0.8];
w0 = [1 2];

% Rotina ode45
[t1, sol1] = ode45(@func, [ti tf], [yi vi], options, m, K, alpha, mu, F0(1), w0(1));
[t2, sol2] = ode45(@func, [ti tf], [yi vi], options, m, K, alpha, mu, F0(2), w0(1));
[t3, sol3] = ode45(@func, [ti tf], [yi vi], options, m, K, alpha, mu, F0(2), w0(2));

% Graficos
figure(1) % F0 = 0
subplot(2, 1, 1)
plot(t1, sol1(:, 1))
title("F0 = 0")
xlabel("t/s")
ylabel("y/m")

subplot(2, 1, 2)
plot(sol1(:, 1), sol1(:, 2))
hold on
plot(0, 0, 'or')
title("F0 = 0")
xlabel("y/m")
ylabel("v/ms-1")

figure(2) % F0 = 0.8; w0 = 1
subplot(2, 2, 1)
plot(t2, sol2(:, 1))
title("F0 = 0.8; w0 = 1")
xlabel("t/s")
ylabel("y/m")

subplot(2, 2, 3)
plot(sol2(:, 1), sol2(:, 2))
title("F0 = 0.8; w0 = 1")
xlabel("y/m")
ylabel("v/ms-1")

% F0 = 0.8; w0 = 2
subplot(2, 2, 2)
plot(t3, sol3(:, 1))
title("F0 = 0.8; w0 = 2")
xlabel("t/s")
ylabel("y/m")

subplot(2, 2, 4)
plot(sol3(:, 1), sol3(:, 2))
title("F0 = 0.8; w0 = 2")
xlabel("y/m")
ylabel("v/ms-1")



% % Gráficos y/t e v/t
% figure(1)
% subplot(3, 2, 1)
% plot(t1, sol1(:, 1))
% title("F0 = 0")
% xlabel("t/s")
% ylabel("y/m")
% 
% subplot(3, 2, 2)
% plot(t1, sol1(:, 2))
% title("F0 = 0")
% xlabel("t/s")
% ylabel("v/ms-1")
% 
% subplot(3, 2, 3)
% plot(t2, sol2(:, 1))
% title("F0 = 0.8; w0 = 1")
% xlabel("t/s")
% ylabel("y/m")
% 
% subplot(3, 2, 4)
% plot(t2, sol2(:, 2))
% title("F0 = 0.8; w0 = 1")
% xlabel("t/s")
% ylabel("v/ms-1")
% 
% subplot(3, 2, 5)
% plot(t3, sol3(:, 1))
% title("F0 = 0.8; w0 = 2")
% xlabel("t/s")
% ylabel("y/m")
% 
% subplot(3, 2, 6)
% plot(t3, sol3(:, 2))
% title("F0 = 0.8; w0 = 2")
% xlabel("t/s")
% ylabel("v/ms-1")
% 
% % Graficos espaço de fases
% figure(2)
% subplot(3, 1, 1)
% plot(sol1(:, 1), sol1(:, 2))
% title("F0 = 0")
% xlabel("y/m")
% ylabel("v/ms-1")
% 
% subplot(3, 1, 2)
% plot(sol2(:, 1), sol2(:, 2))
% title("F0 = 0.8; w0 = 1")
% xlabel("y/m")
% ylabel("v/ms-1")
% 
% subplot(3, 1, 3)
% plot(sol3(:, 1), sol3(:, 2))
% title("F0 = 0.8; w0 = 2")
% xlabel("y/m")
% ylabel("v/ms-1")
