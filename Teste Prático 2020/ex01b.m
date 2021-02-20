clear 
close
clc

% Constantes
L = 1;
h = 0.05;
tol = 1e-7;

x = [ -L:h:L ];
y = [ -L:h:L ];
M = length(x);
% Para o mesh()
[ X,Y ] = meshgrid(x, y);

% Matriz do potêncial em todo o espaço
VOld = zeros(M);

% Em x = -L, V = -1
VOld(1, :) = -1;

% Em x = L, V = 1
VOld(end, :) = 1;

% Em y = +/-L, V = x/L
VOld(:, end) = x / L;
VOld(:, 1) = x / L;

% Criar matriz de pontos de fronteira
% Se lim(i, j) == 1 então é ponto de fronteira e não se pode alterar.
lim = zeros(M);
lim(end, :) = 1;
lim(1, :) = 1;
lim(:, end) = 1;
lim(:, 1) = 1;

% Criar a função f(x, y)
% A função é constante nos yy
f = 100 * sin(x);

% Método sobre-relaxação sucessiva
alpha = 2 / (1 + (pi / M));
V = VOld;

for ni = 1:1000
    for i = 2:M - 1
        for j = 2:M - 1
            if not(lim(i, j))
                % Se (i, j) não for um ponto da fronteira podemos alterar.
                V(i, j) = (1 - alpha) * VOld(i, j) + alpha * 0.25 * (V(i + 1, j) + V(i - 1, j) + V(i, j + 1) + V(i, j - 1) - h^2 * f(i));
            else
                % Caso contrário o potêncial mantém-se.
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

% Plot do potêncial
figure(1)
mesh(X, Y, V)
zlabel('Potêncial (V)')
ylabel('y')
xlabel('x')

% Cálculo do campo Elétrico
% Como E = - grad(V), podemos calcular E da seguinte forma
[ Ex,Ey ] = gradient(V, h, h);

Ex = -Ex;
Ey = -Ey;

% Como o campo Elétrico é um campo vetorial, podemos usar o quiver() para o
% representar melhor.
figure(2)
quiver(X, Y, Ex, Ey)
ylabel('y')
xlabel('x')
xlim([ -L L ])
ylim([ -L L ])

% O módulo do campo Elétrico pode ser calulado como
E = sqrt(Ex.^2 + Ey.^2);
figure(3)
mesh(X, Y, E)
zlabel('Potêncial (E)')
ylabel('y')
xlabel('x')