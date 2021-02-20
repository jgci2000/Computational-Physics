clear
close
clc

beta = 2;
a = 0;
b = 2*pi;
N = 1000;
n = 4;
aux = 1 / (2*pi)^n;

theta = rand(n, N) * 2 * pi;

prod = 1;
for j = 1:n
    for k = j+1:n
        prod = prod .* abs(exp(1i * theta(j, :)) - exp(1i * theta(k, :))).^beta;
    end
end

INum = aux * (b - a)^n * mean(prod)
