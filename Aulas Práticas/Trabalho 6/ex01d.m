clear varaibles
close all
clc

dt = 0.1;
tf = 102.3;
t = 0:dt:tf;

N = length(t);

dw = 2 * pi / (N * dt);
wmin = -N * dw / 2;
wmax = ((N / 2) - 1) * dw;
w = wmin:dw:wmax;

y = exp(-1i * 10 * t) + exp(1i * 20 * t);
fty = fftshift(fft(y));

plot(w, real(fty), '.')
