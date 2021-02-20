clear
close
clc

N = 1E4;
d = 6;
a = -1;
b = 1;

Vd = (b - a)^d;
IExt = d * 2^d / 3;
c = 0;

for i = 1:1000
    xi = rand(d, N);
    f = sum(xi.^2);
    
    INum = (b - a)^d * mean(f);
    
    erroI = Vd * std(f) / sqrt(N);
    
    if INum >= IExt - erroI && INum <= IExt + erroI
        c = c + 1;
    end
end

fracao = c / 1000;
fprintf('A fração de estimativas que pertence ao intervalo é %f.\n', fracao)


