clear
close
clc

a = 1;
dx = 0.001;
x = -a:dx:a;

B = 0; % Valor esperado para o método de Shooting
nShooting = 50;
guess(1) = 1;
guess(2) = 2;
tol = 1E-7;

for i = 1:nShooting
    psi = zeros(1, length(x));
    psi(1) = 0; % Cond de fronteira
    psi(end) = 0;
    psi(2) = 0.0001; % Para iniciar o método de Numerov
    
    E = guess(i);
    g = 2 * E;
    aux = (dx^2 * g) / 12;
    for n = 2:length(x) - 1
        psi(n + 1) = (1 + aux)^-1 * (-(1 + aux) * psi(n - 1) + 2 * (1 - 5 * aux) * psi(n));
    end
    
    C = trapz(x, psi.^2);
    psiNorm = psi / sqrt(C);
    result(i) = psiNorm(end);

    if i > 1
        m = (result(i) - result(i - 1)) / (guess(i) - guess(i - 1));
        guess(i + 1) = guess(i) + (B - result(i)) / m;
        if abs(guess(i + 1) - guess(i)) < tol
            E = guess(i)
            break
        end
    end
end