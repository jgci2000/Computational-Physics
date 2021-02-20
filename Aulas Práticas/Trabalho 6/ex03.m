clear variables
close all
clc

zi = 0;
zf = 4;
Nz = 256;
z = linspace(zi, zf, Nz);
dz = (zf - zi) / Nz;

xi = -5;
xf = 5;
N = 256;
x = linspace(xi, xf, N);
dx = (xf - xi) / N;

dk = 2 * pi / (N * dx);
kmin = -N * dk / 2;
kmax = ((N / 2) - 1) * dk;
k = kmin:dk:kmax;

q = zeros(N, Nz); % q(x, z)
q(:, 1) = sech(x);
q0FTexp = fftshift(fft(q(:, 1))) .* (exp(1i * k.^2 .* z(1) / 2).');

options = odeset('RelTol', 1e-9, 'AbsTol', 1e-9 .* ones(1, N));
[z, qFTexp] = ode45(@f3, [zi zf], q0FTexp, options, N, k);

for n=1:Nz
    qt(n,:)=qFTexp(n,:).*exp(-1i.*k.^2*z(n)/2);
    q(n,:)=ifft(ifftshift(qt(n,:)));
end

z = linspace(zi, zf, Nz);
mesh(x, z, abs(q).^2)
