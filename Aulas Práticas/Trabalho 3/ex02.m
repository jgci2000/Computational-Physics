clear all
close all
clc


k = 16;
m = 1;
w = sqrt(k/m);

h_lim = 2 * sqrt(2) / w;
h = [0.001 0.01 0.1 0.5 1];
erro = zeros(1, length(h));

fv = @(x) -k * x / m;
fx = @(v) v;

for n = 1:length(h) - 1
    tf = 10;
    dt = h(n);
    t = 0:dt:tf;
    
    x = zeros(1, length(t));
    v = zeros(1, length(t));
    x(1) = 1;
    for i = 1:length(t) - 1
        r1v = fv(x(i));
        r1x = fx(v(i));
        r2v = fv(x(i) + r1x * dt / 2);
        r2x = fx(v(i) + r1v * dt / 2);
        r3v = fv(x(i) + r2x * dt / 2);
        r3x = fx(v(i) + r2v * dt / 2);
        r4v = fv(x(i) + r3x * dt);
        r4x = fx(v(i) + r3v * dt);
        
        
        v(i + 1) = v(i) + (1/6)*(r1v + 2*r2v + 2*r3v + r4v) * dt;
        x(i + 1) = x(i) + (1/6)*(r1x + 2*r2x + 2*r3x + r4x) * dt;
    end
    erro(n) = abs(x(end) - cos(sqrt(k / m) * tf));
end

plot(log10(h), log10(erro))