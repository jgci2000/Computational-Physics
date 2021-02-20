% Program to study how the standard error (of the mean) depends on the
% number of samples
% - we want to calculate the standard deviation of the mean of N samples
% (calculating the volume of a pyramid)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
clc


rng(13)   % give a "seed" to the Matlab random number generator
% this way the sequence of random numbers generated are the same every time
% we run the program

% parameters:
L = 2;
Nvals = [10, 100, 1000, 10000, 100000];   % number of samples to get the "mean"
n = 1000;    % number of experiments/samples of the "mean" ( = the integral) for each "N" value


% get exact value of integral:
I_exact = L^3 / 3;



for i=1:length(Nvals)   % loop over different N values

    N = Nvals(i)
    
    clear x y f diff2
    
    for j=1:n   % loop over n experiments (N samples in each experiment)

        % generate two vectors of random numbers (for x and y coordinates):
        % (the random coordinates must be generated between -L/2 and L/2)
        x = L * (rand(1,N) - 0.5);   % row vector
        y = L * (rand(1,N) - 0.5);

        % calculate f(x) values:
        f = L - 2 * max([ abs(x); abs(y) ]);
        
        % calculate integral by multiplying the average of the sampled "f" values
        % by the integration area:
        I_MC = L^2 * mean(f);
        diff2(j) = (I_MC - I_exact)^2;   % square of distance from exact value
    
    end

    errvals(i) = sqrt( mean(diff2) );
    
end

% get theoretical error values:
N_th = logspace( log10(min(Nvals)), log10(max(Nvals)), 100 );  % use 100 N values in the same range as before
err_th = L^2 * std(f) * N_th.^(-1/2);
% we used the most recent "f" values, for the biggest N in "Nvals", to have the best
% estimate of the standard deviation of the "f" values

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% plot results:
figure(1)
loglog(Nvals, errvals, 'rs');
xlabel('N')
ylabel('standard error of the mean')
hold on
loglog(N_th, err_th, 'k-');

% numerical error values match the expected values perfectly









