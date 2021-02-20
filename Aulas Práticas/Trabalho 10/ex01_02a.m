clear
close
clc

b = 1;
a = 0;
N = 1000;

x = rand(1, N);
y = sqrt(1 - x.^2);

Iest = (b - a) * mean(y)
Iext = pi / 4

sigma = std(y);
erro = (b - a) * sigma * N^(-1/2)
erroEst = sqrt(mean((Iest - Iext)^2))