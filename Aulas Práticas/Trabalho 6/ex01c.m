clear variables
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

y = sin(10 * t) + sin(10.05 * t);

ffty = fftshift(fft(y));
plot(w, (dt * abs(real(ffty))) .^ 2, '.')
