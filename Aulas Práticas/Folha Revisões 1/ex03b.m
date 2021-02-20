clear variables
close all
clc

% Constantes Globais
z0 = 1;
v0z = 16;
g = -9.8;
vlim = 6.8;

% Tempo
dt = 0.01;
tf = 5;
t = 0:dt:tf;

% Inicialização de Vetores
z = zeros(1, length(t));
vz = zeros(1, length(t));
z(1) = z0;
vz(1) = v0z;

% Funções
fz = @(vz) vz;
fv = @(vz) g * (1 + (norm(vz) * vz / vlim^2));

% Método Runge-Kutta 3ª Ordem
for n = 1:length(t) - 1
    if(z(n) <= 0)
        idx = n;
        break
    end
    r1v = fv(vz(n));
    r1z = fz(vz(n));
    r2v = fv(vz(n) + r1v * dt / 2);
    r2z = fz(vz(n) + r1v * dt / 2);
    r3v = fv(vz(n) - r1v * dt + 2 * r2v * dt);
    r3z = fz(vz(n) - r1v * dt + 2 * r2v * dt);
    
    vz(n + 1) = vz(n) + (r1v / 6 + 2 * r2v / 3 + r3v / 6) * dt;
    z(n + 1) = z(n) + (r1z / 6 + 2 * r2z / 3 + r3z / 6) * dt;
end

z = z(1:idx - 1);
vz = vz(1:idx - 1);
t = t(1:idx - 1);

% Plots
plot(t, z)
    