clear
close
clc

M = [35 49 63 81 101 123];
ni = zeros(1, length(M));
tol = 1E-7;

for k = 1:length(M)
    x = linspace(-1, 1, M(k));
    y = linspace(-1, 1, M(k));
    [X, Y] = meshgrid(x, y);
    h = 2 * 1 / (M(k) - 1);
    
    lim = zeros(M(k));
    lim(:, 1) = 1;
    lim(:, end) = 1;
    lim(1, :) = 1;
    lim(end, :) = 1;
    
    Told = zeros(M(k));
    q = - 2 * (2 - X.^2 - Y.^2);
    T = zeros(M(k));
    
    for n = 1:100000
        for i = 2:M(k) - 1
            for j = 2:M(k) - 1
                if not(lim(i, j))
                    T(i, j) = 0.25 * (Told(i + 1, j) + Told(i - 1, j) + Told(i, j + 1) + Told(i, j - 1) - h^2 * q(i, j));
                else
                    T(i, j) = Told(i, j);
                end
            end
        end
        if sqrt(sum((T - Told).^2)) / sqrt(sum(T.^2)) < tol
            break
        end
        Told = T;
    end
    ni(k) = n;
end

figure(1)
plot(log(M), log(ni), 'o-r')
m = polyfit(log(M), log(ni), 1);
disp(['Declive = ', num2str(m(1))])
xlabel('ln(M)')
ylabel('ln(ni)')

figure(2)
mesh(X, Y, T)
xlabel("X")
ylabel("Y")
zlabel("T")

