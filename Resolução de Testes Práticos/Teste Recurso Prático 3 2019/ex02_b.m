clear
close
clc

N = 1e5;
d = 6;

a = 0;
b = 1;
Vd = (b - a)^d;

xi = rand(d, N);
f = 1;

for i = 1:d
    f = f .* xi(i, :);
end

for j = 1:d
    for k = j+1:d
        f = f .* (xi(j, :) - xi(k, :)).^2;
    end
end

INum = Vd * sum(f) / N
erro = std(f) * Vd / sqrt(N)


IAn = 1;

for j = 0:d-1
    IAn = IAn * (factorial(j + 1))^2 * factorial(j) / factorial(d + j + 1);
end
IAn


