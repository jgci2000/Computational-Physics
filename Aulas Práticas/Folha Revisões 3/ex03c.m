clear
close 
clc

L = 2;
N = 50000;
d = 7;
a = -L/2;
b = L/2;

IExt = L^d / d

xi = L * rand(d-1, N) - L/2;

f = L - 2*max(abs(xi));

INum = (b - a)^(d - 1) * mean(f)