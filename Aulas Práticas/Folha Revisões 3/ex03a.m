clear
close 
clc

L = 2;
N = 50000;
a = -L/2;
b = L/2;

IExt = L^3 / 3

x = L * rand(1, N) - L/2;
y = L * rand(1, N) - L/2;

f = L - 2*max(abs(x), abs(y));

INum = (b - a)^2 * mean(f)