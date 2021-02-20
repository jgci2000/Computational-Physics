function derivadas = f3(t,solucao)
derivadas = zeros(2,1);
x = solucao(1);
v = solucao(2);
% Esta linha é necessária e faz do vetor de saída um vetor coluna.
k = 16;
m = 1;
% O vetor solucao tem os valores de x e v para o tempo t em que a
% função é chamada pela rotina ode45.
derivadas(1) = v;
% Escreva acima a expressão da derivada de x em função de solucao(1)
% e de solucao(2).
derivadas(2) = - k * x / m;
% Escreva a acima expressão da derivada de v em função de solucao(1)
% e de solucao(2).
end