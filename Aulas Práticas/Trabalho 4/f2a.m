function derivadas = f2a(t, solucao, epsilon)
derivadas = zeros(2,1);
y = solucao(1);
v = solucao(2);
% Esta linha � necess�ria e faz do vetor de sa�da um vetor coluna.
% epsilon = 0.1;
% O vetor solucao tem os valores de x e v para o tempo t em que a
% fun��o � chamada pela rotina ode45.
derivadas(1) = v;
% Escreva acima a express�o da derivada de x em fun��o de solucao(1)
% e de solucao(2).
derivadas(2) = - y - epsilon * (y^2 - 1) * v;
% Escreva a acima express�o da derivada de v em fun��o de solucao(1)
% e de solucao(2).
end