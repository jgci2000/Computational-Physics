clear all
close all
clc

%% a)

g = 9.8;
vl = 6.8;
t0 = 0;
tf = 2;
h = 0.001;

t = t0:h:tf;
v(1, length(t)) = 0;

for i = 1:length(t) - 1
    v(i + 1) = v(i) + h * y(v(i), vl, g);
end
length(v)
length(t)
figure(1)
plot(t, v, '.r');
hold on
plot(t, vz(vl, g, t), 'ob', 'MarkerSize', 0.1);

%% b)

g = 9.8;
vl = 6.8;
t0 = 0;
tf = 0.5;
h = [0.0001 0.001 0.01 0.1];
%h = 0.0005:0.0005:0.1;
erros = zeros(1, length(h));

for i = 1:length(h)
    dt = h(i);
    t = t0:dt:tf;
    v = zeros(1, length(t));
    for n = 1:length(t) - 1
        v(n + 1) = v(n) + dt * y(v(n), vl, g);
    end
    erros(i) = abs(vz(vl, g, 0.5) - v(end));
end

figure(2)
plot(h, erros, '.');
figure(3)
plot(log(h), log(erros), '.');
exp = polyfit(log(h), log(erros), 1);
lsline
figure(4)
plot(exp(1)*log(h) + exp(2));


%% c)

g = 9.8;
vl = 6.8;
z0 = 1;
v0 = 16;
h = 0.001;
tf = 3;
t = 0:h:tf;
z = zeros(1, length(t));
z(1) = z0;
v = zeros(1, length(t));
v(1) = v0;

for n = 1:length(t) - 1
    if z(n) < 0
        idxn = n + 1;
        break
    end
    v(n + 1) = v(n) + h * y(v(n), vl, g);
    z(n + 1) = z(n) + h * v(n);
end

z = z(1:idxn);
t = t(1:idxn);

t_interp = interp1(z, t, 0);

figure(5)
plot(t, z, '.');


%% Functions

function f = y(v, vl, g)
    f = -g*(1 + ((abs(v) * v) / vl^2));
end

function f = vz(vl, g, t)
    f = -vl * tanh(g * t / vl);
end