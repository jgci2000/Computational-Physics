clear varaibles
close all
clc

L = 10;
h = 0.01;
x = 0:h:L;
N = length(x);

v_baixo = 1 * ones(1, N);                  
v_cima = 1 * ones(1, N);  
v_principal = -2 * ones(1, N);  

A = diag(v_baixo(2:N), -1) + diag(v_principal, 0) + diag(v_cima(1:N - 1), 1);

y = ones(length(2:N-1), 1);

sol = eigs(A, 3, 'sm')