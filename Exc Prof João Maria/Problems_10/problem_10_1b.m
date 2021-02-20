% Program to estimate integral of functions using random numbers (Monte Carlo method)
% (in higher dimensions)
% (calculate the "volume" of a d-dimensional hypersphere)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
clc


rng(13)   % give a "seed" to the Matlab random number generator
% this way the sequence of random numbers generated ar ethe same every time
% we run the program

% parameters:
R = 1;
a = 0; b = 1;   % limits of the interval of integration
d = 5;   % number of dimensions of the hypersphere
N = 10000;   % number of Monte Carlo samples


% generate vector of random numbers:
x = rand(N,d-1);   % each column corresponds to a dimension
x2 = x.^2;
sumx2 = sum(x2,2);   % summing along the 2nd dimension of vector "x2"
f = zeros(N,1);
f(sumx2 <= 1) = sqrt( 1 - sumx2(sumx2 <= 1) );

% calculate integral by multiplying the average of the sampled "f" values
% by the integration "volume":
I_MC = (b-a)^(d-1) * mean(f)
I_exact = pi^(d/2) / gamma(d/2+1) / 2^d*R^d



