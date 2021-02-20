clear all
close all
clc


m = 1;
k = 1;
a = -0.1;

tf = 30;
dt = 0.01;
t = 0:dt:tf;

x = zeros(1, length(t));
v = zeros(1, length(t));
x(1) = 1;
v(1) = 1;

for i = 1:length(t) - 1
    f = -(k / m) * (x(i) + 2 * a * x(i)^3);
    v(i + 1) = v(i) + dt * f;
    x(i + 1)= x(i) + dt * v(i + 1);
end

figure(1)
plot(t, x)
title("Position")

figure(2)
plot(t, v)
title("Velocity")

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

x_max1
x_max2
T