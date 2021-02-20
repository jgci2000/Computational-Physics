clear
close
clc

L = 2;
a = -L/2;
b = L/2;
n = 100;
A = L^2;

IExt = L^3 / 3;

NVals = 100:1000:50000;
NN = length(NVals);
errorVals = zeros(1, length(NN));

for i = 1:NN
    clear x y f diff2
    diff2 = zeros(1, n);
    N = NVals(i);

    for k = 1:n
        x = L * rand(1, N) - L/2;
        y = L * rand(1, N) - L/2;
        
        f = L - 2*max(abs(x), abs(y));
        INum = (b - a)^2 * mean(f);
        
        diff2(k) = (INum - IExt)^2;
    end
    errorVals(i) = sqrt(mean(diff2));
end

sigma = std(f);

plot(NVals.^(-1/2) * A, errorVals)
m = polyfit(NVals.^(-1/2) * A, errorVals, 1);



