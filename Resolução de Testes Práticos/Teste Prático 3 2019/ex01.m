clear
close
clc

L = 4;
dx = 0.1;
dy = 0.1;
x = [ -L/2:dx:L/2 ];
y = [ -L/2:dy:L/2 ];
M = length(x);
[ X,Y ] = meshgrid(x, y);

zOld = zeros(M);
zOld(1, :) = 10;
zOld(M, :) = 12;
zOld(:, 1) = 11 + 2 * x / L;
zOld(:, end) = 11 + 2 * x / L;

f = zeros(M);
for i = 1:M
    for j = 1:M
        if x(i)^2 + y(j)^2 < L^2 / 9
            f(i, j) = 1;
        else
            f(i, j) = 0;
        end
    end
end

% Gauss - Seidel

z = zOld;
tol = 1E-7;

for nIt = 1:100000
    for i = 2:M-1
        for j = 2:M-1
            z(i, j) = 0.25 * (z(i+1,j) + z(i-1,j) + z(i,j+1) + z(i,j-1) - dx^2*f(i,j));
        end
    end
    if sqrt(sum(sum((z - zOld).^2))) / sqrt(sum(sum(z.^2))) < tol
        break
    end
    zOld = z;
end

figure(1)
mesh(X, Y, z)
zlim([8.5 13])
xlim([-L/2 L/2])
ylim([-L/2 L/2])

[ dzdx,dzdy ] = gradient(z);
da = sqrt(1 + dzdx.^2 + dzdy.^2) * dx^2;
A = sum(sum(z .* da));

fprintf('A área da membrana %f.\n', A)


% Gauss - Seidel com vara

zOld = zeros(M);
zOld(1, :) = 10;
zOld(M, :) = 12;
zOld(:, 1) = 11 + 2 * x / L;
zOld(:, end) = 11 + 2 * x / L;

ind = floor(M/2);
zOld(ind, ind) = 11;

lim = zeros(M);
lim(ind, ind) = 1;
z = zOld;
tol = 1E-7;

for nIt = 1:100000
    for i = 2:M-1
        for j = 2:M-1
            if not(lim(i, j))
                z(i, j) = 0.25 * (z(i+1,j) + z(i-1,j) + z(i,j+1) + z(i,j-1) - dx^2*f(i,j));
            else
                z(i, j) = z(i, j);
            end
        end
    end
    if sqrt(sum(sum((z - zOld).^2))) / sqrt(sum(sum(z.^2))) < tol
        break
    end
    zOld = z;
end

figure(2)
mesh(X, Y, z)
zlim([8.5 13])
xlim([-L/2 L/2])
ylim([-L/2 L/2])

[ dzdx,dzdy ] = gradient(z);
da = sqrt(1 + dzdx.^2 + dzdy.^2) * dx^2;
A = sum(sum(z .* da));

fprintf('A área da membrana %f.\n', A)
