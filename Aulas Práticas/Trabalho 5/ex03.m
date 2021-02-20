clear varaibles
close all
clc

lambda = 0.1;
Q = 2.1E6;
R = 1E-3;

h = 1E-6;
r = 0:h:R;
N = length(r);

v_baixo = 1 - h ./ (2 .* r);                  
v_cima = 1 + h ./ (2 .* r);
v_principal = -2 * ones(1, N);

A = diag(v_baixo(2:N), -1) + diag(v_principal, 0) + diag(v_cima(1:N - 1), 1);
A(1, 1) = -2; 
A(1, 2) = 2; 
A(end, end) = 1; 
A(end, end - 1) = 0; 

b = ones(N, 1) * - h^2 * Q / lambda;
b(end) = 20;

T = linsolve(A, b);

plot(r, T);