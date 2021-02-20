clear
close
clc

T = 1.8; % a)
%T = 2.7; % b)

N = 10000;
n = 100;

comp(1, 1) = exp(-8 / T);
comp(2, 1) = exp(8 / T);
comp(1, 2) = exp(-4 / T);
comp(2, 2) = exp(4 / T);
comp(:, 3) = 1;
comp(1, 4) = exp(4 / T);
comp(2, 4) = exp(-4 / T);
comp(1, 5) = exp(8 / T);
comp(2, 5) = exp(-8 / T);

S = ones(n);
SSVP = 4 * ones(n);

aux=1:1:n;
menos=circshift(aux,[0 -1]);
mais=circshift(aux,[0 +1]);

NMC = 15000;
M = zeros(1, NMC);

for k = 1:NMC
    for i = 1:n
        for j = 1:n
            for tent = 1:N
                al = rand(1);
                if al > 0.5
                    spin = 1;
                else
                    spin = -1;
                end
                if comp((S(i, j) + 3) / 2, 3 + SSVP(i, j) / 2) > al
                    S(i, j) = spin;
                    SSVP(i, mais(j)) = SSVP(i, mais(j)) - 2 * S(i, j);
                    SSVP(i, menos(j)) = SSVP(i, menos(j)) - 2 * S(i, j);
                    SSVP(mais(i), j) = SSVP(mais(i), j) - 2 * S(i, j);
                    SSVP(menos(i), j) = SSVP(menos(i), j) - 2 * S(i, j);
                    break
                end
            end
        end
    end
    M(k) = sum(S);
end

plot(1:NMC, M)

