function derivadas = f3(z, qtexp, N, k)
derivadas = zeros(N, 1);

qt = qtexp ./ (exp(1i .* k.^2 * z / 2).');
q = ifft(ifftshift(qt));
V = 1i .* q .* q .* conj(q);
VT = fftshift(fft(V));

derivadas = VT .* (exp(1i .* k.^2 * z / 2).');
end