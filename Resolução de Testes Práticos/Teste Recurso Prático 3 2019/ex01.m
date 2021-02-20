clear
close
clc

h = 0.01;
tol = 1e-7;

x = [ -1:h:1 ];
y = [ -1:h:1 ];
M = length(x);

% Pontos para mesh()
[ X,Y ] = meshgrid(x, y);

% Criar VOld
VOld = zeros(M);

VOld(1, :) = 1 - y.^2;
VOld(M, :) = 1 - y.^2;
VOld(:, 1) = -1 + x.^2;
VOld(:, M) = -1 + x.^2;

% Criar matriz de pontos de fronteira
% Se lim(i, j) == 1 então é ponto de fronteira e não se pode alterar
lim = zeros(M);
lim(1, :) = 1;
lim(M, :) = 1;
lim(:, 1) = 1;
lim(:, M) = 1;

% Criar função f(x, y)
f = zeros(M);

for i = 1:M
    for j = 1:M
        f(i, j) = -16 * (1 - max(abs(x(i)), abs(y(j))));
    end
end

% alpha para método de sobre-relaxação
alpha = 2 - 2 * pi / M;

% Método de sobre-relaxação
V = VOld;

for ni = 1:1000
    for i = 1:M
        for j = 1:M
            if not(lim(i, j))
                % Se o ponto não for da fronteira
                V(i, j) = (1 - alpha) * VOld(i, j) + alpha * 0.25 * (V(i + 1, j) + V(i - 1, j) + V(i, j + 1) + V(i, j - 1) - h^2 * f(i, j));
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
mesh(X, Y, V);

% Achar o pronto mais próximo de x = 1/2 e y = 1/3
x1 = 1/2;
y1 = 1/3;

% Indíces dos pontos x1 e y1
ix = round((x1 + 1) / h + 1);
iy = round((y1 + 1) / h + 1);

% Aproximar as derivadas por diferenças finitas
dvdx2 = (V(ix - 1, iy) - 2 * V(ix, iy) + V(ix + 1, iy)) / h^2;
dvdy2 = (V(ix, iy - 1) - 2 * V(ix, iy) + V(ix, iy + 1)) / h^2;

resNum = dvdy2 + dvdx2 - f(ix, iy);
resAn = 0;
% O resNum é suposto dar zero, contudo devido a erros de truncatura e
% aproximação pelo método da sobre-relaxação, dá um número muito próximo de
% zero. A sua ordem de grandeza, 10^-6, é próxima da de tol, 10^-7. Esta
% disparidade é devido ao erro do cálculo das derivadas por diferenças
% finitas.














