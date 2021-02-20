clear
close
clc

beta = 2;
a = 0;
b = 2*pi;
N = 1000;
d = 2;
aux = 1 / (2*pi)^2;

theta1 = rand(1, N) * 2 * pi;
theta2 = rand(1, N) * 2 * pi;

f = abs(exp(1i * theta1) - exp(1i * theta2)).^beta;

INum = aux * (b - a)^d * mean(f)
