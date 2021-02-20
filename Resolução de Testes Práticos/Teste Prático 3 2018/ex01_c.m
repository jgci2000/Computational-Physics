clear
close
clc
rng(23)

beta = 2;
a = 0;
b = 2*pi;
N = 1000000;
n = 4;
aux = 1 / (2*pi)^n;

theta = rand(n, N) * 2 * pi;

for i = 1:2
    theta = rand(n, N) * 2 * pi;
    prod = 1;
    for j = 1:n
        for k = j+1:n
            prod = prod .* abs(exp(1i * theta(j, :)) - exp(1i * theta(k, :))).^beta;
        end
    end
    
    INum(i) = aux * (b - a)^n * mean(prod);
    erro(i) = (b - a)^n * std(prod) / sqrt(N);
    rng(267)
end

difErro = abs(erro(1) - erro(2));

fprintf('A diferença do erro é %f.\n', difErro)
