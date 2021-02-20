clear
close
clc

dx = 0.001;
x = 0:dx:10;
N = length(x);

n = 1;
Eexact = ((3*pi/sqrt(2)) * (n - 1/4))^(2/3)

B = 0; % Valor esperado para o método de Shooting
nShooting = 500;
guess(1) = 2.8;
guess(2) = 3;
tol = 1E-7;

for i = 1:nShooting
    psi = zeros(1, N);
    psi(1) = 0; % Cond de fronteira
    psi(N) = 0;
    psi(N - 1) = dx; % Para iniciar o método de Numerov
    
    E = guess(i);
    g = 2 * (E - 2*x);
    aux = (dx^2 * g) / 12;
    for n = N-1:-1:2
        psi(n - 1) = (1 + aux(n - 1))^-1 * (2 * (1 - 5 * aux(n)) * psi(n) - (1 + aux(n + 1)) * psi(n + 1));
    end
    
    result(i) = psi(1);
    
    if i > 1
        m = (result(i) - result(i - 1)) / (guess(i) - guess(i - 1));
        guess(i + 1) = guess(i) + (B - result(i)) / m;
        if abs(guess(i + 1) - guess(i)) < tol
            E = guess(i)
            break
        end
    end
end

C = trapz(x, psi.^2);
psiNorm = psi / sqrt(C);

plot(x, psiNorm)
