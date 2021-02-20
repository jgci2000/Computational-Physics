function derivadas = f2b(t, solucao, epsilon, F0)
derivadas = zeros(2,1);
y = solucao(1);
v = solucao(2);
% Esta linha é necessária e faz do vetor de saída um vetor coluna.
% epsilon = 0.1;
% O vetor solucao tem os valores de x e v para o tempo t em que a
% função é chamada pela rotina ode45.
derivadas(1) = v;
% Escreva acima a expressão da derivada de x em função de solucao(1)
% e de solucao(2).
derivadas(2) = - y - epsilon * (y^2 - 1) * v + F0 * cos(1.7 * t);
% Escreva a acima expressão da derivada de v em função de solucao(1)
% e de solucao(2).
end