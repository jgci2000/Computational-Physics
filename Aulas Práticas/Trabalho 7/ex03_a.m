clear variables
close all
clc

L = 50;
tf = 500;
k = 0.93;
c = 0.094;
ro = 8.9;

dx = 0.5;
dt = 0.1;
t = 0:dt:tf;
x = 0:dx:L;
N = length(x) - 2;

T = zeros(length(x), length(t)); % T(x, t) --> T(n, i)
T(:, 1) = 50 * sin(2 * pi * x / L);
cte = k * dt / (c * ro * dx^2);

v_baixo = -ones(1, N);
v_cima = -ones(1, N);
v_principal = ((2 / cte) + 2) * ones(1, N);
A = diag(v_baixo(2:N), -1) + diag(v_principal, 0) + diag(v_cima(1:N - 1), 1);
A(1, 1) = (2 / cte) + 2;
A(1, 2) = -1;
A(end, end) = (2 / cte) + 2;
A(end, end - 1) = -1;

b = zeros(length(x) - 2, 1);
cteB = (2 / cte) - 2;

for i = 1:length(t) - 1
    b = T(1:end - 2, i) + cteB * T(2:end - 1, i) + T(3:end, i);
    b(1) = b(1) + T(1, i + 1);
    b(end) = b(end) + T(end, i + 1);
    
    T(2:end - 1, i + 1) = linsolve(A, b);
end

contourf(x, t, T')