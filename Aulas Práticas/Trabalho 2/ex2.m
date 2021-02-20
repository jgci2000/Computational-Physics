clear all
close all
clc

tf = 10;
dt = 0.0001;
t = 0:dt:tf;

r = zeros(2, length(t));
v = zeros(2, length(t));
r(1, 1) = 0.47;
v(2, 1) = 8.2;

for n = 1:length(t) - 1
    eq = -4 * pi^2 * r(:, n) / norm(r(:, n))^3;
    v(:, n + 1) = v(:, n) + dt * eq;
    r(:, n + 1) = r(:, n) + dt * v(:, n + 1);
end

x = r(1, 1:end);
y = r(2, 1:end);
idx_rdm = randi(length(x));

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

theta = mod(atan2(y,x),2*pi);

for i = 1:length(t)
    if t(i) >= T / 2
        idx = i;
        break
    end
end

for i = 1:length(t(1:idx))
    dTheta = theta(i + 1) - theta(i);
    dR = norm(r(:, i + 1)) - norm(r(:, i));
    dist(i) = (dR)^2 * dTheta / 2;
end

plot(x, y, '.')
hold on
plot(x(idx_rdm), y(idx_rdm), 'or')
plot(0, 0, 'oy')
axis([-0.5 0.5 -0.5 0.5])
set(gca,'PlotBoxAspectRatio',[1 1 1])

figure(2)
plot(t(1:idx), dist, '.')
axis fill