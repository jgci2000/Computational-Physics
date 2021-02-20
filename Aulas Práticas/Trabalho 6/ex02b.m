clear variables
close all
clc

dz = 0.01;
zf = 4;
z = 0:dz:4;
Nz = length(z);

dx = 0.1;
xi = -30;
xf = 30;
x = xi:dx:xf;
N = length(x);

dk = 2 * pi / (N * dx);
kmin = -N * dk / 2;
kmax = (N / 2 - 1) * dk;
k = kmin:dk:kmax;

q = zeros(Nz, N);
q(1, :) = sech(x);

ftq0 = fftshift(fft(q(1, :)));
ftq = zeros(Nz, N);

for i = 1:Nz
    ftq(i, :) = ftq0 .* exp(-1i .* k .^ 2 .* z(i) / 2);
    q(i, :) = ifft(ifftshift(ftq(i, :)));
end

mesh(x, z, abs(q) .^ 2)


