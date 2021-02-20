clear variables
close all
%clc

D = zeros(8, 8);
U = zeros(8, 8);
L = zeros(8, 8);

D(1, 1) = -1; D(2, 2) = -1; D(3, 3) = -1; D(4, 4) = -sqrt(2) / 2; D(5, 5) = -1; D(6, 6) = 1; D(7, 7) = sqrt(3) / 2; D(8, 8) = -1;
U(1, 4) = sqrt(2) / 2; U(1, 5) = 1; U(2, 4) = sqrt(2) / 2; U(3, 7) = 0.5; U(4, 6) = -1; U(4, 7) = 0.5; U(5, 8) = 1;
L(7, 4) = -sqrt(2) / 2; L(8, 7) = -sqrt(3) / 2;
A = U + D + L;

b = zeros(8, 1);
b(6, 1) = 10000;

xOld = zeros(8, 1);
xOld(:, 1) = 1;

[rows, col] = size(A);
erroMax = 1E-7;

for ni = 1:1000
    x = xOld;
    for i = 1:rows
        s = A(i, :) .* x';
        s(1, i) = 0;
        x(i, 1) = (b(i) - sum(s)) / A(i, i);
    end
    if max(abs(x - xOld)) / max(abs(x)) < erroMax
        break
    end
    xOld = x;
end



