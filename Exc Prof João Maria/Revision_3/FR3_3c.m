% Program to calculate the volume of a hyper-pyramid using Monte Carlo
% integration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
clc


rng(13)   % give a "seed" to the Matlab random number generator
% this way the sequence of random numbers generated are the same every time
% we run the program

% parameters:
L = 2;
d = 7;
N = 50000;   % number of Monte Carlo samples


% generate d-1 vectors of random numbers (for all integration coordinates):
% (the random coordinates must be generated between -L/2 and L/2)
r = L * (rand(d-1,N) - 0.5);

% calculate f values:
f = L - 2 * max( abs(r) );


I_MC = mean(f) * L^(d-1)
I_exact = L^d / d





