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

y = sin(10 * t) + sin(40 * t);
ffty = fftshift(fft(y));

fmax = 1 / (2 * dt);
wmax_novo = pi / dt;
w_novo = zeros(1, N);

for i = 1:N
    if w(i) > wmax_novo
        w_novo(i) = 2 * wmax_novo - w(i);
    else
        w_novo(i) = w(i);
    end
end

subplot(2, 1, 1)
plot(w, (dt * abs(ffty)) .^ 2, '.')
title("Antes")
subplot(2, 1, 2)
plot(w_novo, (dt * abs(ffty)) .^ 2, '.')
title("Depois")