% Program to study how the standard error (of the mean) depends on the
% number of samples
% - we want to calculate the standard deviation of the mean of N samples
% (calculating the area of a circle)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
clc


rng(13)   % give a "seed" to the Matlab random number generator
% this way the sequence of random numbers generated ar ethe same every time
% we run the program

% parameters:
R = 1;
a = 0; b = 1;   % limits of the interval of integration
Nvals = [10, 100, 1000, 10000, 100000];   % number of samples to get the "mean"
n = 1000;    % number of experiments/samples of the "mean" ( = the integral) for each "N" value

% get exact value of integral:
I_exact = R^2 * pi / 4;



for i=1:length(Nvals)   % loop over different N values

    N = Nvals(i)
    
    clear x f diff2
    
    for j=1:n   % loop over n experiments (N samples in each experiment)

        % generate vector of random numbers:
        x = rand(N,1);

        % calculate f(x) values:
        f = sqrt( 1 - x.^2 );

        % calculate integral by multiplying the average of the sampled "f" values
        % by the interval:
        I_MC = (b-a) * mean(f);
        diff2(j) = (I_MC - I_exact)^2;   % square of distance from exact value
    
    end

    errvals(i) = sqrt( mean(diff2) );
    
end

% get theoretical error values:
N_th = logspace( log10(min(Nvals)), log10(max(Nvals)), 100 );  % use 100 N values in the same range as before
err_th = (b-a) * std(f) * N_th.^(-1/2);
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







