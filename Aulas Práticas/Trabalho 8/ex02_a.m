clear variables
close all
clc

L = 1;
h = 0.05;
Vint = 1;
Vext = 0;
M = 2 * L  / h + 1;
idx = floor(M/5);

x = -L:h:L;
y = -L:h:L;
[X, Y] = meshgrid(x, y);

lim = zeros(M);
lim(:, 1) = 1;
lim(:, end) = 1;
lim(1, :) = 1;
lim(end, :) = 1;
lim(idx:end - idx + 1, idx:end - idx + 1) = 1;
lim(idx + 1:end - idx, idx + 1:end - idx) = 0;

Vold = zeros(M);
Vold(:, 1) = Vext;
Vold(:, end) = Vext;
Vold(1, :) = Vext;
Vold(end, :) = Vext;
Vold(idx:end - idx + 1, idx:end - idx + 1) = Vint;
Vold(idx + 1:end - idx, idx + 1:end - idx) = 0;

erroMax = 1E-7;
V = zeros(M);

for ni = 1:1000
    for i = 2:M - 1
        for j = 2:M - 1
            if not(lim(i, j))
                V(i, j) = 0.25 * (Vold(i + 1, j) + Vold(i - 1, j) + Vold(i, j + 1) + Vold(i, j - 1));
            else
                V(i, j) = Vold(i, j);
            end
        end
    end
    if sqrt(sum(V.^2) - sum(Vold.^2)) / sqrt(sum(V.^2)) < erroMax
        break
    end
    Vold = V;
end

mesh(X, Y, V)


