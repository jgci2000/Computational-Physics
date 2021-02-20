clear
close
clc

N = 1000;
d = 2;

a = 0;
b = 1;

xi = rand(d, N);
f = xi(1, :) .* xi(2, :) .* (xi(1, :) - xi(2, :)).^2;

Vd = (b - a)^d;

INum = Vd * sum(f) / N


