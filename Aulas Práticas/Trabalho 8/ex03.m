clear variables
close all
clc

L = 1;
Vint = 1;
Vext = 0;

h = 0.025;
X = 0:2 * h:2 * L;
Y = 0:h:L;

Vold = zeros(length(X), length(Y));
Vold(10 + 1:end-10, 10 + 1:end-10) = Vint;


[rows, col] = size(Vold);
erroMax = 1E-7;
V = Vold;

for ni = 1:1000
    for i = 2:rows - 1
        for j = 2:col - 1
            V(i, j) = 0.25 * (V(i + 1, j) + V(i - 1, j) + V(i, j + 1) + V(i, j - 1));
        end
    end
    if sqrt(sum(V.^2) - sum(Vold.^2)) / sqrt(sum(V.^2)) < erroMax
        break
    end
    Vold = V;
end

[Ex,Ey]=gradient(V,h,h);
Ex=-Ex;
Ey=-Ey;
figure(3)
quiver(X,Y,Ex,Ey)

Q=4*trapz(X,-Ex(:,1));
