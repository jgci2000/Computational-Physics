clear
close
clc

M = [35 49 63 81 101 123];
ni = zeros(1, length(M));
tol = 1E-7;

for iM = 1:length(M)
    x = linspace(-1, 1, M(iM));
    y = linspace(-1, 1, M(iM));
    [X, Y] = meshgrid(x, y);
    h = 2 * 1 / (M(iM) - 1);
    
    lim = zeros(M(iM));
    lim(:, 1) = 1;
    lim(:, end) = 1;
    lim(1, :) = 1;
    lim(end, :) = 1;
     
    q = - 2 * (2 - X.^2 - Y.^2);
    
    alfa_rec = 2 - 2*pi/M(iM);
    alphavals = linspace(alfa_rec * 0.96 + 0.08, alfa_rec * 0.94 + 0.12, 10);
    na = length(alphavals);
    nia = zeros(1, na);
    
    for ia = 1:na
        alpha = alphavals(ia);
        T = zeros(M(iM));
        Told = zeros(M(iM));
        for n = 1:100000
            T = Told;
            for i = 2:M(iM) - 1
                for j = 2:M(iM) - 1
                    if not(lim(i, j))
                        T(i, j) = (1-alpha) * Told(i,j) + alpha/4 * (T(i + 1, j) + T(i - 1, j) + T(i, j + 1) + T(i, j - 1) - h^2 * q(i, j));
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
        nia(ia) = n;
    end
    ni(iM) = min(nia);
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
