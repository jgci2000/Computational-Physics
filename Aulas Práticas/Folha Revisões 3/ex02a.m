clear
close
clc

omega = 2;
xMax = 5 / sqrt(omega);
tol = 10E-7;
nShooting = 2000;
dx = 0.001;

x = -xMax:dx:xMax;
N = length(x);

% valor de x cujo psiRight = psiLeft
xMatch = 0.15;

% encontrar xMatch no vetor de x
ix = round((xMatch + xMax) / dx + 1);

% 2 vetores de x
xLeft = x(1:ix);
xRight = x(ix + 1:end);
NLeft = length(xLeft);
NRight = length(xRight);

% vetores do potencial
VLeft = 1/2 * omega^2 * xLeft.^2;
VRight = 1/2 * omega^2 * xRight.^2;

% valores de fronteira para o dois vetores
psiInf = 0;
psiLeft2 = dx; % numero pequeno
psiRight2 = psiLeft2; % solucoes pares
% psiRight2 = -psiLeft2; % solucoes impares

B = 0; % valor esperado para o método de Shooting
% Variar para ter niveis de E diferentes
guess(1) = 8.6; % E(1)
guess(2) = 8.7; % E(2)

for i = 1:nShooting
    E = guess(i);
    
    psiLeft = zeros(1, NLeft);
    psiRight = zeros(1, NRight);
    % parte esquerda de psi
    % condicoes para comecar o método ne Numerov
    psiLeft(1) = psiInf;
    psiLeft(2) = psiLeft2;
    
    g = 2 * (E - VLeft);
    aux = (dx^2 * g) / 12;
    for n = 2:NLeft - 1
        psiLeft(n + 1) = (1 + aux(n + 1))^-1 * (-(1 + aux(n - 1)) * psiLeft(n - 1) + 2 * (1 - 5 * aux(n)) * psiLeft(n));
    end
    
    % parte direita de psi
    % condicoes para comecar Numerov
    psiRight(end) = psiInf;
    psiRight(end - 1) = psiRight2;
    
    clear g % pode ter tamanhos diferentes
    g = 2 * (E - VRight);
    aux = (dx^2 * g) / 12;
    
    for n = NRight-1:-1:2
        psiRight(n - 1) = (1 + aux(n - 1))^-1 * (2 * (1 - 5 * aux(n)) * psiRight(n) - (1 + aux(n + 1)) * psiRight(n + 1));
    end
    
    % forcar que psiRight e psiLeft sejam iguais em xMatch
    psiRight = psiRight * psiLeft(end) / psiRight(1);
    
    % plot das solucoes a convergir
    figure(1)
    hold off
    plot(xLeft, psiLeft, 'r')
    hold on
    plot(xRight, psiRight, 'b')
    pause(1)
    
    DLeft = (25/12*psiLeft(end) - 4*psiLeft(end-1) + 3*psiLeft(end-2) - 4/3*psiLeft(end-3) + 1/4*psiLeft(end-4)) / dx;
    DRight = (-25/12*psiRight(1) + 4*psiRight(2) - 3*psiRight(3) + 4/3*psiRight(4) - 1/4*psiRight(5)) / dx;
    
    result(i) = (DLeft - DRight) / (DLeft + DRight);
    if i > 1
        m = (result(i) - result(i - 1)) / (guess(i) - guess(i - 1));
        guess(i + 1) = guess(i) + (B - result(i)) / m;
        if abs(guess(i + 1) - guess(i)) < tol
            E = guess(i)
            break
        end
    end
end

psi = [psiLeft(1:end), psiRight];
C = trapz(x, psi.^2);
psiNorm = psi / sqrt(C);

figure(2)
plot(x, psiNorm, 'r')
title("Psi normailzado")
