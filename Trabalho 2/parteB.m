% João Inácio
% 93039
% PL7
clear variables
close all
clc

% PARTE B

% Constantes
M = 1;
k = 1;
beta = 0.2;
mu = 1.88;
y0 = 0;
v0 = -1.5;

% Vetor t
dt = 0.1;
% Para ter 1024 pontos com um
% passo de dt
% Subtrai-se 1 por que começa em 0
tf = (1024 - 1)* dt;
t = 0:dt:tf;
% Para aumetar a densidade
% espectral 4 vezes temos de multiplicar
% dt por 4 
dt2 = dt * 4;
tf2 = (1024 - 1)* dt2;
t2 = 0:dt2:tf2;

% Constantes para FT
N = length(t);
dw = 2 * pi / (N * dt);
wMax = ((N / 2) - 1) * dw;
wMin = (-N/2) * dw;
% Vetor w centrado em 0
w1 = wMin:dw:wMax;
N2 = length(t2);
dw2 = 2 * pi / (N2 * dt2);
wMax2 = ((N2 / 2) - 1) * dw2;
wMin2 = (-N2/2) * dw2;
w2 = wMin2:dw2:wMax2;

% Rotina ode45()
% Para determinar as posições
% e velocidades
reltol = 3E-14;
abstol_1 = 1E-13;
abstol_2 = 1E-13;
options = odeset('RelTol', reltol, 'AbsTol', [abstol_1 abstol_2]);
[t1, sol1] = ode45(@func, t, [y0 v0], options, M, k, beta, mu);
[t2, sol2] = ode45(@func, t2, [y0 v0], options, M, k, beta, mu);
y1 = sol1(:, 1);
v1 = sol1(:, 2);
y2 = sol2(:, 1);
v2 = sol2(:, 2);

% Rotina fft()
% Dá-se o shit para que os valores
% estejam centrados em 0
F1 = fftshift(fft(y1)) * dt;
dE1 = abs(F1).^2;
F2 = fftshift(fft(y2)) * dt2;
dE2 = abs(F2).^2;

% Encontrar pontos com densidade
% espectral inferior a 10
w1Inf10 = w1(dE1 < 10);
dE1Inf10 = dE1(dE1 < 10);
w2Inf10 = w2(dE2 < 10);
dE2Inf10 = dE2(dE2 < 10);

% Calcular a(t)
% Para calcular a(t) por a ode45()
% podemos pergar na equação diferencial
% e por num membro d2y/dt2 = a. Assim
aOde = M^-1 * (mu * (1 - v1.^2) .* v1 - k * (y1 + beta * y1.^3));
% Para calcular a aceleraçao
% pela transformada de fourier
% usamos a formula
% É necessário fazer a transposta de w1
% uma vez que o matlab usa vetores
% com uma linha para fazer operações
% com os métodos fft()
aFt = (1i * w1').^2 .* F1;
% Temos de fazer a transformada
% inversa para obter a aceleração
% Divide-se por dt, pois o os métodos
% de fft usam F(k) e não F(w) 
% (F(w) = dt*F(k))
aFtInv = ifft(ifftshift(aFt / dt));

%Gráficos
figure(1)
subplot(2, 1, 1)
plot(t1, y1)
xlim([0 102.3])
title("Gráfico 4")
xlabel("t/s")
ylabel("y/m")

subplot(2, 1, 2)
plot(w1, dE1)
title("Gráfico 5")
xlabel("w/rads-1")
ylabel("Densidade Espectral")

figure(2)
subplot(2, 1, 1)
plot(w1Inf10, dE1Inf10)
title("Gráfico 6")
xlabel("w1/rads-1")
ylabel("Densidade Espectral")

subplot(2, 1, 2)
plot(w2Inf10, dE2Inf10)
title("Gráfico 7")
xlabel("w2/rads-1")
ylabel("Densidade Espectral")

figure(3)
subplot(2, 1, 1)
plot(t1, aOde)
xlim([0 102.3])
ylim([-4 4])
title("Gráfico 8")
xlabel("t/s")
ylabel("y/m")

subplot(2, 1, 2)
plot(t1, aFtInv)
xlim([0 102.3])
ylim([-4 4])
title("Gráfico 9")
xlabel("t/s")
ylabel("y/m")






