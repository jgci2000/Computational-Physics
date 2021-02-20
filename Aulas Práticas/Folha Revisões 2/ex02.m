clear variables
close all
clc

f0 = 1000;
data = load("data.txt");

N = length(data);

dt = 1 / f0;
dw = 2 * pi / (N * dt);
wMax = ((N / 2) - 1) * dw;
wMin = (-N/2) * dw;
w = wMin:dw:wMax;

F = fftshift(fft(data));
dEspectral = abs((F * dt).^2);

plot(w, dEspectral, 'k')

w_sinal = w(dEspectral > 0.04);
f_sinal = w_sinal ./ (2 * pi)

ruidoTemp = dEspectral(dEspectral < 0.04);
ruido = mean(ruidoTemp)
