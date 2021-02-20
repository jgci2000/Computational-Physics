% Infinite square well - Numerov and shooting method
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
clc
close all


% parameters:
a = 1.0;   % size of (half of) well
h = 0.001;   % (h = dx)
toler = 1e-7;   % for shooting method

% define 'x' vector:
x = [-a:h:a];
N = length(x);


% analytic 'E' value:
E_an = 1^2 * pi^2 / (8 * a^2)


% first two guesses of 'E':
E(1) = 1.5;
E(2) = 1.6;
% (we will keep extending this vector, we don't know how many elements it
% will have)


% first two values of 'psi':
psi(1) = 0;
psi(2) = h;   % could be any small number...


% Do Shooting method:
psif(1) = 1;   % we just need a number bigger than 'toler', to be able to enter the "while"
% ('psif' is a vector that will contain the 'psi(end)' values. At the moment this vector only has one element.)
iE = 0;  % index of 'E' vector
while ( abs( psif(end) - 0 ) > toler )   % the stopping condition is that 'psi' is zero at "x=a"

    iE = iE + 1;
    
    % Do Numerov method with 'E(iE)':----------------------
    g = 2 * E(iE);
    aux = h^2 / 12 * g;

    for k=2:N-1
        psi(k+1) = (1+aux)^(-1) * ( -(1+aux) * psi(k-1) + 2*(1-5*aux) * psi(k) );
    end

    
    % ------------------------------------------------------------
    % plot current estimate of curve:
    figure(1)
    plot(x, psi, 'r-');
    xlim([-a,a]);
    psimax = max(psi);
    psimin = min(psi);
    dpsi = psimax - psimin;
    ylim([psimin - dpsi*0.3, psimax + dpsi*0.3]);
    pause(1.0);   % pause the program for 1 second
    
    
    
    % store last element:
    psif(iE) = psi(end);
    
    
    % make next guess for 'E':
    if(iE>1)
        slope = (psif(iE) - psif(iE-1)) / (E(iE) - E(iE-1));
        E(iE+1) = E(iE) + ( 0 - psif(iE) ) / slope;        
    end


end

E_num = E(end)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% normalize wave function:


% calculate square integral:
I = trapz(x, psi.^2);
psi = psi / sqrt(I);


figure(2)
plot(x, psi, 'r-');
title('normalized wave function');
xlim([-a,a]);
psimax = max(psi);
psimin = min(psi);
dpsi = psimax - psimin;
ylim([psimin - dpsi*0.3, psimax + dpsi*0.3]);
















