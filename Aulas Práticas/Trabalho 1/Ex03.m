clear all
close all
clc

v0 = 80000/3600;
theta = deg2rad(10);
rot = 600;
f = rot/60;
P = 0.70;
R = P / (2 * pi);
A = pi * R ^ 2;
m = 0.45;
ro = 1.225;
wz = 2 * pi * f;
cm = 1;

tf = 5;
dt = 0.001;
t = 0:dt:tf;

r = zeros(3, length(t));
v = zeros(3, length(t));
w = [0; 0; -wz];
g = [0; 0; -9.8];

v(1, 1) = v0 * cos(theta);
v(3, 1) = v0 * sin(theta);

for n = 1:length(t) - 1
    FD = Fd(v(:, n)) / m ;
    FL = (0.5 * cm * ro * A * R * cross(w, v(:, n))) / m;
    a = FD + FL + g;
    v(:, n + 1) = v(:, n) + dt * a;
    r(:, n + 1) = r(:, n) + dt * v(:, n);
    
    if r(3, n) < 0
        idx = n;
        break
    end
end
    
x = r(1, 1:idx);
y = r(2, 1:idx);
z = r(3, 1:idx);
alcance = interp1(z(idx - 1:idx), x(idx - 1: idx), 0)
desvio = interp1(z(idx - 1:idx), y(idx - 1: idx), 0)
plot3(x, y, z, '.')

function f = Fd(v)
    nV = norm(v);
    unitV = v / nV;
    if nV <= 9
        f = -(0.015 * nV ^ 2) * unitV;
    elseif nV > 9 && nV <= 20 
        f = -(0.25147 + 0.17431 * nV - 0.01384 * nV ^ 2 + 0.00054 * nV ^ 3) * unitV;
    else
        f = -(-4.025 + 0.323 * nV) * unitV;
    end
end