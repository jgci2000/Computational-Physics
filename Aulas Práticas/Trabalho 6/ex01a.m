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

y1 = sin(t);
y2 = sin(10 * t);
y3 = sin(t) + sin(10 * t);

fty1 = fftshift(fft(y1));
fty2 = fftshift(fft(y2));
fty3 = fftshift(fft(y3));

espec_density1 = (dt * abs(fty1)) .^ 2;
espec_density2 = (dt * abs(fty2)) .^ 2;
espec_density3 = (dt * abs(fty3)) .^ 2;

subplot(2, 2, 1)
plot(w, espec_density1, '.');
subplot(2, 2, 2)
plot(w, espec_density2, '.');
subplot(2, 2, 3)
plot(w, espec_density3, '.');



