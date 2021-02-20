clear 
close
clc

a = 1;
b = 4 * a;
dx = 0.01;
x = -b:dx:b;
V0 = 20;

B = 0; % Valor esperado para o método de Shooting
nShooting = 200;
guess(1) = 0.5;
guess(2) = 0.6;
tol = 1E-12;

for i = 1:nShooting
    psiProg = zeros(1, length(x));
    psiReg = zeros(1, length(x));
    dpsiReg = zeros(1, length(x));
    dpsiProg = zeros(1, length(x));
    
    E = guess(i);
    g = 2 * (E - V0);
    aux = (dx^2 * g) / 12;
    for n = 2:length(x) - 1
        psiProg(n + 1) = (1 + aux)^-1 * (-(1 + aux) * psi(n - 1) + 2 * (1 - 5 * aux) * psi(n));
    end
    for n = length(x) - 1:-1:2
        psiReg(n - 1) = (1 + aux)^-1 * (-(1 + aux) * psi(n + 1) + 2 * (1 - 5 * aux) * psi(n));
    end
    for n = 1:length(x) - 4
        dpsiReg(n) = dx^-1 * (-25 / 12 * psiReg(n) + 4 * psiReg(n + 1) - 3 * psiReg(n + 2) + 4 * psiReg(n + 3) / 3 - psiReg(n + 4) / 4);
        dpsiProg(n) = dx^-1 * (-25 / 12 * psiProg(n) + 4 * psiProg(n + 1) - 3 * psiProg(n + 2) + 4 * psiProg(n + 3) / 3 - psiProg(n + 4) / 4);
    end
    aux1 = dpsiProg ./ psiProg;
    aux2 = dpsiReg ./ psiReg;
    %     C = trapz(x, psi.^2);
    %     psiNorm = psi / sqrt(C);
    result(i) = (aux1 - aux2) / (aux1 + aux2);

    if i > 1
        m = (result(i) - result(i - 1)) / (guess(i) - guess(i - 1));
        guess(i + 1) = guess(i) + (B - result(i)) / m;
        if abs(guess(i + 1) - guess(i)) < tol
            E = guess(i)
            break
        end
    end
end


