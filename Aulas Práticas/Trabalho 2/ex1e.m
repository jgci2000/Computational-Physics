clearvars
close all
clc

dt = 0.01; tf = 20;
t = 0:dt:tf;

k = 1; m = 1;

x = zeros(1, length(t));
v = zeros(1, length(t));
x(1) = 1;
v(1) = 0;

for n = 1:length(t) - 1
    v(n + 1) = v(n) + dt * (-k * x(n) / m);
    x(n + 1) = x(n) + dt * v(n + 1);
end
em = 0.5 * (m * v.^2 + k * x.^2);

count = 0;
for n = 2:length(x) - 1
    if x(n - 1) <= x(n) && x(n) >= x(n + 1)
        count = count + 1;
        ixd(count)=n;
    end
end

aux=lagr(t(ixd(1)-1:ixd(1)+1),x(ixd(1)-1:ixd(1)+1));
x_max1 = aux(2);
t_x_max1 = aux(1);
aux=lagr(t(ixd(2)-1:ixd(2)+1),x(ixd(2)-1:ixd(2)+1));
x_max2 = aux(2);
t_x_max2 = aux(1);

T = t_x_max2 - t_x_max1;

disp(x_max1)
disp(x_max2)
disp(T)

% figure(5)
% subplot(3, 2, 1)
% plot(t, x)
% title("Euler-Cromer x/t")
% subplot(3, 2, 2)
% plot(t, v)
% title("Euler-Cromer v/t")
% subplot(3, 2, 3)
% plot(x, v)
% title("Euler-Cromer v/x")
% subplot(3, 2, 4)
% plot(t, em)
% title("Euler-Cromer Em/t")
% subplot(3, 2, 5)
% x_an = cos(t);
% plot(t, x_an)
% title("Solução Analítica")