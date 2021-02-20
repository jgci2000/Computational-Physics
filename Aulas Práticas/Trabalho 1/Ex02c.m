clear all 
close all
clc

g = [0; 0; -9.8];
m = 0.057;
v0 = 20;
h0 = 0.7;
w0 = -3000 * 2 * pi / 60;
R = 0.0335;
A = pi * R ^ 2;
theta = 5 * pi / 180;
ro = 1.225;
ti = 0;
tf = 5;
dt = 0.001;
t = ti:dt:tf;
v = zeros(3, length(t));
r = zeros(3, length(t));
w = [0; w0; 0];

v(1, 1) = v0 * cos(theta);
v(3, 1) = v0 * sin(theta);
r(3, 1) = h0;

for n = 1:length(t) - 1
    S = (R .* norm(w)) / (norm(v(:, n)));
    Cd = 0.508  + (22.503 + 4.196 * S ^ -2.5) ^ -0.4;
    Cl = (2.022 + 0.981 * S ^ -1) ^ -1;
    aux = -1 / (2 * m) * Cd * ro * A * norm(v(:, n)) * v(:, n) + g + 1 / (2 * m) * Cl * ro * A * norm(v(:, n)) ^ 2 * cross(w / norm(w), v(:, n) / norm(v(:, n)));
    v(:, n + 1) = v(:, n) + dt * aux;
    r(:, n + 1) = r(:, n) + dt * v(:, n);
    if r(3, n) <= 0
        idx = n;
        break
    end
end

x = r(1, 1:idx);
y = r(2, 1:idx);
z = r(3, 1:idx);

plot(x, z, '.');
alcance = interp1(z(idx - 1:idx), x(idx - 1:idx), 0)

[z_max, ind] = max(z);
aux=lagr(x(ind-1:ind+1),z(ind-1:ind+1));
z_max1 = aux(2);
x_med = aux(1);
aux=lagr(t(ind-1:ind+1),z(ind-1:ind+1));
z_max2 = aux(2);
t_med = aux(1);

function lagr=lagr(xm,ym)
% determinacao de o ma'ximo de uma funcao discreta
%
% input: coordenadas de 3 pontos vizinhos de ordenadas maiores
%            matrizes xm e ym
% output: coordenadas do ponto ma'ximo (xmax,ymax)
%

xab=xm(1)-xm(2);
xac=xm(1)-xm(3);
xbc=xm(2)-xm(3);

a=ym(1)/(xab*xac);
b=-ym(2)/(xab*xbc);
c=ym(3)/(xac*xbc);

xml=(b+c)*xm(1)+(a+c)*xm(2)+(a+b)*xm(3);
xmax=0.5*xml/(a+b+c);

xta=xmax-xm(1);
xtb=xmax-xm(2);
xtc=xmax-xm(3);

ymax=a*xtb*xtc+b*xta*xtc+c*xta*xtb;

lagr(1)=xmax;
lagr(2)=ymax;
end

