clear 
close
clc

n = 3;
l = 1;
dr = 0.001;
r = 0:dr:50;
N = length(r);

Eexact = -0.5 * n^-2

B = 0; % Valor esperado para o método de Shooting
nShooting = 200;
guess(1) = -0.6/9;
guess(2) = -0.7/9;
tol = 1E-12;
gAux(2:N) = -l * (l + 1) ./ r(2:N).^2 + 2 ./ r(2:N);

for i = 1:nShooting
    u = zeros(1, N);
    u(end - 1) = 0.001; % Para iniciar o método de Numerov
    
    E = guess(i);
    g = gAux + 2 * E;
    aux = (dr^2 * g) / 12;
    for k = N - 1:-1:3
        u(k - 1) = (1 + aux(k - 1))^-1 * (2 * (1 - 5 * aux(k)) * u(k) - (1 + aux(k + 1)) * u(k + 1));
    end
    
    u(1)=interp1(r(2:5), u(2:5), 0, 'spline');
    result(i) = u(1);

    if i > 1
        m = (result(i) - result(i - 1)) / (guess(i) - guess(i - 1));
        guess(i + 1) = guess(i) + (B - result(i)) / m;
        if abs(guess(i + 1) - guess(i)) < tol
            E = guess(i)
            break
        end
    end
end
I = trapz(r, u.^2);
u = u / sqrt(I);

R(2:N) = u(2:N)./r(2:N);
R(1) = interp1(r(2:5), R(2:5), 0, 'spline');

plot(r, R)
