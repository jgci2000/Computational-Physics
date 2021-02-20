% Program to study the quantum harmonic oscillator
% (using the shooting and matching method already used)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
clc

% parameters:
w = 2;
xmax = 5 / sqrt(w);   % suggested in the worksheet
h = 0.001;
toler = 1e-7;   % for shooting method

% adjust "xmax", if necessary, to be a multiple of "h":
xmax = h * round(xmax/h);

% define 'x' vector:
x = [-xmax:h:xmax];
N = length(x);

% assign position where the two solutions should be matched up:
x_match = 0.2;  % could be any small number (not too small)

% find index of 'x_match' in the vector 'x':
ind_match = round( (x_match + xmax) / h + 1);

% we will need to approximate twice: from the left and from the right
x_left = x(1:ind_match);
x_right = x(ind_match:N);
N_left = numel(x_left);
N_right = numel(x_right);


% fill up "potential" vectors:
V_left = 1/2 * w^2 * x_left.^2;
V_right = 1/2 * w^2 * x_right.^2;


% set first two values of 'psi' (on both sides):
psi_extreme = 0;
psi_next_left = h;    % could be any small number
psi_next_right = psi_next_left;    % for "even" solution
%psi_next_right = -psi_next_left;   % for "odd" solution


% first two guesses of 'E':
E(1) = 0.4;
E(2) = 0.6;
% (we will keep extending this vector, we don't know how many elements it
% will have)


% Do Shooting method:
reldiff(1) = 1;   % we just need a number bigger than 'toler', to be able to enter the "while"
% ('reldiff' is the relative difference of the derivatives of 'psi_left' and
% 'psi_right' at "x = x_match")
iE = 0;  % index of 'E' vector
while ( abs( reldiff(end) ) > toler )   % the stopping condition is that 'reldiff' is zero

    iE = iE + 1;
      
    % Do Numerov method with 'E(iE)':----------------------
    
    % Do left part of 'psi':-------------------
    g = 2 * (E(iE) - V_left); 
    aux1 = (1 + h^2/12*g);
    aux2 = 2 * (1 - 5*h^2/12*g);
    
    psi_left = zeros(1,N_left);
    psi_left(1) = psi_extreme;
    psi_left(2) = psi_next_left;
          
    for k=2:N_left-1
        psi_left(k+1) = ( -aux1(k-1) * psi_left(k-1) + aux2(k) * psi_left(k) ) / aux1(k+1);
    end

    
    % Do right part of 'psi':
    clear g   % because new 'g' vector might be smaller...
    g = 2 * (E(iE) - V_right);
    aux1 = (1 + h^2/12*g);
    aux2 = 2 * (1 - 5*h^2/12*g);
    
    psi_right = zeros(1,N_right);
    psi_right(N_right) = psi_extreme;
    psi_right(N_right-1) = psi_next_right;
          
    for k=N_right-1:-1:2
        psi_right(k-1) = ( -aux1(k+1) * psi_right(k+1) + aux2(k) * psi_right(k) ) / aux1(k-1);
    end

    
    
    % plot unmatched curves:
    figure(1)
    plot(x_left, psi_left, 'r-');
    hold on
    plot(x_right, psi_right, 'b-');
    hold off
    pause(1.0);
    
    % Do matching:
    ratio = psi_left(N_left) / psi_right(1);
    psi_right = psi_right * ratio;

    % plot matched curves:
    figure(1)
    plot(x_left, psi_left, 'r-');
    hold on
    plot(x_right, psi_right, 'b-');
    hold off
    pause(1.0);
    
    
    % estimate derivatives of 'psi' at x_match:
    D_left = ( 25/12*psi_left(N_left) - 4*psi_left(N_left-1) + 3*psi_left(N_left-2) - 4/3*psi_left(N_left-3) + 1/4*psi_left(N_left-4) ) / h;
    D_right = ( -25/12*psi_right(1) + 4*psi_right(2) - 3*psi_right(3) + 4/3*psi_right(4) - 1/4*psi_right(5) ) / h;
   
        
    % calculate quantity for shooting method:
    reldiff(iE) = (D_left - D_right) / (D_left + D_right);
    
    
    
    % make next guess for 'E':
    if(iE>1)
        slope = (reldiff(iE) - reldiff(iE-1)) / (E(iE) - E(iE-1));
        E(iE+1) = E(iE) + ( 0 - reldiff(iE) ) / slope;        
    end


end

E_num = E(end)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% combine the two parts:
psi = [psi_left(1:end-1), psi_right];

% normalize:
I = trapz(x, psi.^2);
psi = psi / sqrt(I);


figure(2)
plot(x, psi, 'r-');
title('normalized wave function');
xlim([-xmax, xmax]);
psimax = max(psi);
psimin = min(psi);
dpsi = psimax - psimin;
ylim([psimin - dpsi*0.3, psimax + dpsi*0.3]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% find the value of "x" where E = V:
x_lim = sqrt(2 * E_num) / w;

% get "x" values where "x >= x_lim":
% (this is where E <= V) - only the positive part!
xnew = x(x>=x_lim);

% get "psi" values where "x >= x_lim":
psinew = psi(x>=x_lim);

% calculate probability that particle is in the "forbidden region":
prob_num = 2 * trapz(xnew, psinew.^2)  % multiply by "2" to also consider the negative part
prob_an = 1 - erf(1)









