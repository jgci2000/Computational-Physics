clear variables
close all
clc

dx = 0.1;
xi = -20;
xf = 20;
x = xi:dx:xf;
Nx = length(x) - 2;

dz = 0.1;
zi = 0;
zf = 16;
z = zi:dz:zf;
Nz = length(z);

alpha = 100;
epsilon = 1i * dz / (4 * dx^2);

phi = zeros(length(x), Nz);
phi(:, 1) = exp(-0.5 * x.^2);
phi(1, :) = 0;
phi(end, :) = 0;

v_baixo = -ones(1, Nx);
v_cima = -ones(1, Nx);
v_principal = ((1 / epsilon) + 2 + 2 * alpha * dx^2 * x(2:end - 1).^2);

A = diag(v_baixo(2:Nx), -1) + diag(v_principal, 0) + diag(v_cima(1:Nx - 1), 1);
A(1, 1) = ((1 / epsilon) + 2 + 2 * alpha * dx^2 * x(2).^2);
A(1, 2) = -1;
A(end, end) = ((1 / epsilon) + 2 + 2 * alpha * dx^2 * x(end - 1).^2);
A(end, end - 1) = -1;

b = zeros(Nx, 1);

for n = 1:Nz - 1
    for i = 1:Nx
        cteb = ((1 / epsilon) - 2 - 2 * alpha * dx^2 * x(i + 1).^2);
        b(i) = phi(i, n) + cteb * phi(i + 1, n) + phi(i + 2, n);
    end
    
    b(1) = b(1) + phi(1, n + 1);
    b(end) = b(end) + phi(end, n + 1);
    
    phi(2:end - 1, n + 1) = linsolve(A, b);
end

contourf(x, z, abs(phi'))








