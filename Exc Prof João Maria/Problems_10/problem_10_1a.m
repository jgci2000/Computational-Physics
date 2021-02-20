% Program to estimate integral of functions using random numbers (Monte Carlo method)
% (calculate area of a circle)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
clc


rng(13)   % give a "seed" to the Matlab random number generator
% this way the sequence of random numbers generated ar ethe same every time
% we run the program

% parameters:
R = 1;
a = 0; b = 1;   % limits of the interval of integration
N = 10000;   % number of Monte Carlo samples


% generate vector of random numbers:
x = rand(N,1);

% calculate f(x) values:
f = sqrt( 1 - x.^2 );

% calculate integral by multiplying the average of the sampled "f" values
% by the interval:
I_MC = (b-a) * mean(f)
I_exact = R^2 * pi / 4






