% João Inácio
% 93039
% PL7
clear variables
close all
clc

% PARTE A

% Constantes
M = 1;
k = 1;
beta = 0.2;

% Inicialização da rotine ode45()
% Representam o erro máximo para
% o método ode45()
reltol = 3E-14;
abstol_1 = 1E-13;
abstol_2 = 1E-13;

% Condições Iniciais
y0 = 0;
% A amplitude positiva que tem de dar no final
yf = 1.3; 
v0 = -1.5;
t0 = 0;
tf = 60;
dt = 0.1;
% Vetor de tempos com dt = 0.1
tOde = t0:dt:tf;

% Constantes para método Shooting
% Número de vezes que este método é executado
% A partir de um certo número, não 
% altera a aproximação devido ao erro
Nshooting = 10; 
% Erro máximo para parar o método shooting
tol = 1E-12;
% Duas estimativas para o parametro
% a determinar, neste caso é mu
guess(1) = 1.4;
guess(2) = 1.6;

% Método Shooting
% for para executar o método Shooting
% Para quando o valor encontrado for
% menor do que o erro especificado a cima
for i = 1:Nshooting
    % Dar clear de A e idx
    % pois a função, dependendo de 
    % mu pode ter mais ou menos máximos
    clear A idx
    % A cada iteração o valor de mu 
    % fica como a estimativa de indice i
    mu = guess(i);
    % Resolução numérica da ODE
    % no ficheiro func.m
    options = odeset('RelTol', reltol, 'AbsTol', [abstol_1 abstol_2]);
    [t, sol] = ode45(@func, tOde, [y0 v0], options, M, k, beta, mu);
    y = sol(:, 1);
    v = sol(:, 2);
    % for usado para encontrar os indices dos
    % pontos máximos no array de posições y
    c = 0;
    for n1 = 2:length(y) - 1
        if y(n1 - 1) <= y(n1) && y(n1) >= y(n1 + 1)
            c = c + 1;
            % Usar a função lagr.m para encontrar
            % os máximos da solução da ODE            
            aux = lagr(t(n1 - 1:n1 + 1), y(n1 - 1:n1 + 1));
            A(c) = aux(1, 2);
            idx(c) = n1;
        end
    end
    % Vetor result tem os valores médios dos máximos
    % para comparar com o máximo que queremos, 1.3
    result(i) = mean(A);
    if i > 1
        % Calculamos m e b do método da secante
        % de forma a obter a próxima estimativa
        % para mu de acordo com o valor
        % final de y especificado
        m = (result(i) - result(i - 1)) / (guess(i) - guess(i - 1));
        % A próxima estimativa é calculada
        % tendo em conta do valor de yf
        guess(i + 1) = guess(i) + (yf - result(i)) / m;
        % Se o valor absoluto da subtração
        % da próxima estimativa com a estimativa
        % atual for menor do que tol, para e
        % guarda o valor estimado de mu, que tem
        % um erro da ordem de tol, ou seja, 10^-12
        if abs(guess(i + 1) - guess(i)) < tol
            mu = guess(i);
            break
        end
    end
end

% Determinação do período
% Para determinar o período vamos 
% pegar no vetor com os indices dos
% máximos, idx, para calcular a diferença
% entre dos tempos entre dois máximos 
% consecutivos e por fim fazer 
% a média de todas as diferenças
% para obter uma aproximação do período
for i = 1:length(idx) - 1
    n1 = idx(i);
    n2 = idx(i + 1);
    aux1 = lagr(t(n1 - 1:n1 + 1), y(n1 - 1:n1 + 1));
    aux2 = lagr(t(n2 - 1:n2 + 1), y(n2 - 1:n2 + 1));
    T(i) = aux2(1, 1) - aux1(1, 1);
end
periodo = mean(T);

display("Mu: "+ mu);
display("Período: " + periodo);

% Gráficos
figure(1)
subplot(2, 1, 1)
plot(t, y)
title("Gráfico 1")
xlabel("t/s")
ylabel("y/m")

subplot(2, 1, 2)
plot(y, v)
hold on
title("Gráfico 2")
xlabel("y/m")
ylabel("v/ms-1")

% Gráfico para o atrator
% É usado os últimos 300 pontos para o fazer
figure(2)
plot(y(end-300:end), v(end-300:end))
hold on
plot(0, 0, '.b')
title("Gráfico 3")
xlabel("y/m")
ylabel("v/ms-1")









