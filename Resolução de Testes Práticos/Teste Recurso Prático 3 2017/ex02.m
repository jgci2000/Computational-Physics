clear
close
clc

a = 20;
L = a / 2;
tol = 1e-7;

h = 0.1;
x = [ -L:h:L ];
y = [ -L:h:L ];
z = [ -L:h:L ];
M = length(x);
[ X,Y ] = meshgrid(x, y);

% Esféra
r1 = 5;
ro = 1;
Q = ro * 4/3 * pi * r1^3;

% Supeerfície Esférica
r2 = 10;

% Criar VOld
VOld = zeros(M);

for i = 1:M
    for j = 1:M
        if sqrt(x(i)^2 + y(j)^2) <= r1
            VOld(i, j) = 1;
        end
    end
end

% Criar matriz de pontos de fronteira
% Se lim(i, j) == 1 então é ponto de fronteira e não se pode alterar
lim = VOld;
for i = 1:M
    for j = 1:M
        if sqrt(x(i)^2 + y(j)^2) > r2
            lim(i, j) = 1;
        end
    end
end

% alpha para método de sobre-relaxação
alpha = 2 / (1 + pi / M);

% Método de sobre-relaxação
V = VOld;

for ni = 1:1000
    for i = 2:M-1
        for j = 2:M-1
            if not(lim(i, j))
                % Se o ponto não for da fronteira
                V(i, j) = (1 - alpha) * VOld(i, j) + alpha * 0.25 * (V(i + 1, j) + V(i - 1, j) + V(i, j + 1) + V(i, j - 1));
            else
                V(i, j) = VOld(i, j);
            end
        end
    end
    dif = sqrt(sum(V - VOld).^2) / sqrt(sum(V).^2);
    if dif < tol
        break
    end
    VOld = V;
end

% Gráfico
contourf(X, Y, V);
