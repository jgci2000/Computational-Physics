clear variables
close all
clc

L = 50;
tf = 500;
k = 0.93;
c = 0.094;
ro = 8.9;

dx = 0.5;
dt = 0.1;
t = 0:dt:tf;
x = 0:dx:L;

T = zeros(length(x), length(t)); % T(x, t) --> T(n, i)
T(2:end - 1, 1) = 100;

for i = 1:length(t) - 1
    T(1, i) = 0;
    T(end, i) = 0;
    for n = 2:length(x) - 1
        T(n, i + 1) = T(n, i) + k * dt / (c * ro * dx^2) * (T(n - 1, i) - 2 * T(n, i) + T(n + 1, i));
    end
end

figure(1)
contourf(t, x, T)

for n = 1:length(x)
    if x(n) == L / 4
        idx = n;
    end
end

TL4 = zeros(1, length(t));
for i = 1:length(t)
    TL4(i) = T(idx, i);
end
figure(3)
plot(t, TL4)

% dx = 0.5;
% dt = 0.2;
% t = 0:dt:tf;
% x = 0:dx:L;
% 
% k * dt / (c * ro * dx^2) = 0.8... 
% 
% T = zeros(length(x), length(t)); % T(x, t) --> T(n, i)
% T(2:end - 1) = 100;
% 
% for i = 1:length(t) - 1
%     T(1, i) = 0;
%     T(end, i) = 0;
%     for n = 2:length(x) - 1
%         T(n, i + 1) = T(n, i) + k * dt / (c * ro * dx^2) * (T(n - 1, i) - 2 * T(n, i) + T(n + 1, i));
%     end
% end
% 
% figure(2)
% contourf(t, x, T)



