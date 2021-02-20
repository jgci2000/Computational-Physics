clear variables
close all
clc

u = 1E-3;
L = 1;
T = 1E3;
v0 = 1;

h = 0.01;
x = 0:h:L;

fv = @(w, y) -u * y * w^2 /T;
fy = @(v) v;

guess(1) = 6E3;
guess(2) = 7E3;
tol = 1E-12;

for i = 1:length(x)
    y = zeros(1, length(x));
    v = zeros(1, length(x));
    y(1) = 0;
    v(1) = v0;
    
    w = guess(i);
    
    for n = 1:length(x) - 1
        r1y = fy(v(n));
        r1v = fv(w, y(n));
        r2y = fy(v(n) + r1v * h / 2);
        r2v = fv(w, y(n) + r1y * h / 2);
        r3y = fy(v(n) + r2v * h / 2);
        r3v = fv(w, y(n) + r2y * h / 2);
        r4y = fy(v(n) + r3v * h);
        r4v = fv(w, y(n) + r3y * h);
        
        v(n + 1) = v(n) + (1/6)*(r1v + 2*r2v + 2*r3v + r4v) * h;
        y(n + 1) = y(n) + (1/6)*(r1y + 2*r2y + 2*r3y + r4y) * h;
    end
    
    result(i) = y(end);
    
    plot(x, y)
    pause(1);
    
    if i > 1
        m = (result(i) - result(i - 1)) / (guess(i) - guess(i - 1));
        b = result(i) - m * guess(i);
        guess(i + 1) = guess(i) + (0 - result(i)) / m;
        if abs(guess(i + 1) - guess(i)) < tol
            w = guess(i)
            break
        end
    end
end
