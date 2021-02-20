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
xMatch = 0.15;

% Encontrar xMatch no vetor de x
ix = round((xMatch + xMax) / dx + 1);

% 2 vetores de x
xLeft = x(1:ix);
xRight = x(ix + 1:end);
NLeft = length(xLeft);
NRight = length(xRight);

% Vetores do potencial
VLeft = 1/2 * omega^2 * xLeft.^2 + lambda * xLeft.^2;
VRight = 1/2 * omega^2 * xRight.^2 + lambda * xRight.^2;

% valores de fronteira para o dois vetores
psiInf = 0;
psiLeft2 = dx; % numero pequeno
psiRight2 = psiLeft2; % solucoes pares
% psiRight2 = -psiLeft2; % solucoes impares

B = 0; % valor esperado para o método de Shooting
% Variar para ter niveis de E diferentes
% Como a energia do sistema vai ser pouco afetada pela energia da parte não
% harmónica, podemos fazer uma aproximação de E = (1/2 + n) * w para termos
% duas estimativas iniciais.
% Guardar ambas as energias
ENum = zeros(1, 5);
EHarmAn = zeros(1, 5);

for n = 0:4
    % É preciso dar clear, pois podem ter tamanhos diferentes.
    clear guess result
    
    EHarmAn(n + 1) = (n + 1/2) * omega;
    guess(1) = EHarmAn(n + 1) - 0.2; % E(1)
    guess(2) = EHarmAn(n + 1) + 0.2; % E(2)
    
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
        for k = 2:NLeft - 1
            psiLeft(k + 1) = (1 + aux(k + 1))^-1 * (-(1 + aux(k - 1)) * psiLeft(k - 1) + 2 * (1 - 5 * aux(k)) * psiLeft(k));
        end
        
        % parte direita de psi
        % condicoes para comecar Numerov
        psiRight(end) = psiInf;
        psiRight(end - 1) = psiRight2;
        
        clear g % pode ter tamanhos diferentes
        g = 2 * (E - VRight);
        aux = (dx^2 * g) / 12;
        
        for k = NRight-1:-1:2
            psiRight(k - 1) = (1 + aux(k - 1))^-1 * (2 * (1 - 5 * aux(k)) * psiRight(k) - (1 + aux(k + 1)) * psiRight(k + 1));
        end
        
        % forçar que psiRight e psiLeft sejam iguais em xMatch
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
                ENum(n + 1) = guess(i);
                psi(:, n + 1) = [psiLeft(1:end), psiRight];
                break
            end
        end
    end
end

fprintf('Os valores de energia de n = 0 até n = 4 são: \n')
for i = 1:5
    fprintf('%f \n', ENum(i))
end

for i = 1:5
    C = trapz(x, psi(:, i).^2);
    psiNorm = psi(:, i) / sqrt(C);

    figure(2)
    plot(x, psiNorm, 'r')
    title("Função de Onda Normalizada")
    xlabel('x')
    ylabel('|psi(x)|^2')
    pause(2)
end