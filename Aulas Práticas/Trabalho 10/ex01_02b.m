clear 
close
clc

d = 4;
N = 1000;
a = 0;
b = 1;
Vd = 1;

x = rand(d - 1, N);
x2 = x.^2;
y = zeros(1, N);

for i = 1:N
    if sum(x2(:, i)) <= 1
        y(i) = sqrt(1 - sum(x2(:, i)));
    else
        y(i) = 0;
    end
end

Iext = 0.5^d * pi^(d / 2) / gamma(1 + d / 2)
Iest = (b - a) * mean(y)

sigma = std(y);
erro = Vd * sigma * N^(-1/2)
erroEst = sqrt(mean((Iest - Iext)^2))
