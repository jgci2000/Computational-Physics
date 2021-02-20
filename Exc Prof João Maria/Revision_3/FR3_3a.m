% Program to calculate the volume of a pyramid using Monte Carlo
% integration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
clc


rng(13)   % give a "seed" to the Matlab random number generator
% this way the sequence of random numbers generated are the same every time
% we run the program

% parameters:
L = 2;
N = 50000;   % number of Monte Carlo samples


% generate two vectors of random numbers (for x and y coordinates):
% (the random coordinates must be generated between -L/2 and L/2)
x = L * (rand(1,N) - 0.5);   % row vector
y = L * (rand(1,N) - 0.5);

% calculate f(x) values:
f = L - 2 * max([ abs(x); abs(y) ]);

% calculate integral by multiplying the average of the sampled "f" values
% by the integration area:
I_MC = L^2 * mean(f)
I_exact = L^3 / 3










