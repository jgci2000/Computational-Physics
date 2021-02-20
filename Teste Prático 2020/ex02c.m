clear
close
clc

% Constantes
omega = 4;
lambda = -0.008;
xMax = 5 / sqrt(omega);
tol = 10E-7;
nShooting = 2000;
dx = 0.001;

x = [ -xMax:dx:xMax ];
N = length(x);

% Valor de x cujo psiRight = psiLeft
xMatch = 0;

% Encontrar xMatch no vetor de x
ix = round((xMatch + xMax) / dx + 1);

% 2 vetores de x
% Neste problema só nos interessa o xLeft, já que é esse vetor que contem
% os valores para x>=0;
xLeft = x(1:ix);
NLeft = length(xLeft);

% Vetores do potencial
VLeft = 1/2 * omega^2 * xLeft.^2 + lambda * xLeft.^2;

% valores de fronteira
psiInf = 0;
psiLeft2 = dx; % numero pequeno

B = 0; % valor esperado para o método de Shooting
% Variar para ter niveis de E diferentes
% Como a energia do sistema vai ser pouco afetada pela energia da parte não
% harmónica, podemos fazer uma aproximação de E = (1/2 + n) * w para termos
% duas estimativas iniciais.

n = 1;
EHarmAn = (n + 1/2) * omega;
guess(1) = EHarmAn - 0.2; % E(1)
guess(2) = EHarmAn + 0.2; % E(2)

for i = 1:nShooting
    E = guess(i);
    
    psiLeft = zeros(1, NLeft);
    % parte esquerda de psi
    % condicoes para comecar o método ne Numerov
    psiLeft(1) = psiInf;
    psiLeft(2) = psiLeft2;
    
    g = 2 * (E - VLeft);
    aux = (dx^2 * g) / 12;
    for k = 2:NLeft - 1
        psiLeft(k + 1) = (1 + aux(k + 1))^-1 * (-(1 + aux(k - 1)) * psiLeft(k - 1) + 2 * (1 - 5 * aux(k)) * psiLeft(k));
    end
    
    % psi(0) = 0
    result(i) = psiLeft(NLeft);
    
    if i > 1
        m = (result(i) - result(i - 1)) / (guess(i) - guess(i - 1));
        guess(i + 1) = guess(i) + (B - result(i)) / m;
        if abs(guess(i + 1) - guess(i)) < tol
            ENum = guess(i);
            break
        end
    end
end

fprintf('Os valores de energia em n = 1: %f\n', ENum)
fprintf('O valor de E1 na primeira alínea foi 6.001494.\n')
% Os valores de energia pelos dois métodos estão próximos. Contudo fazer
% matching é mais preciso.
% Criar o vetor para valores x > 0
% psi(x) = -psi(-x)
k = 1;
for i = NLeft:-1:2
    psiRight(k) = -psiLeft(i);
    k = k + 1;
end

psi = [psiLeft(1:end), psiRight];
C = trapz(x, psi.^2);
psiNorm = psi / sqrt(C);

figure(2)
plot(x, psiNorm, 'r')
title("Função de Onda Normalizada")
xlabel('x')
ylabel('|psi(x)|^2')
