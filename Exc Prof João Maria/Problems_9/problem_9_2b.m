% Hydrogen atom - Numerov and shooting method
% (calculating only the radial wave function)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
clc
close all


% parameters:
rmax = 50;   % "size" of hydrogen atom
h = 0.001;   % (h = dx)
toler = 1e-7;   % for shooting method

% quantum numbers:
n = 3;
l = 1;

% define 'r' vector:
r = [0:h:rmax];
N = length(r);

% initialize 'u' and 'g' vector:
u = zeros(1, N);
g = zeros(1, N);


% analytic 'E' value:
E_an = -1/2 * n^(-2)


% first two guesses of 'E':
E(1) = -0.6/9;
E(2) = -0.7/9;
% (we will keep extending this vector, we don't know how many elements it
% will have)


% first two values of 'u':
% we are solving for "u(r) = r * R(r)", where "R(r)" is the radial wave
% function
u(N) = 0;
u(N-1) = h/1000;   % could be any small number...


% Do Shooting method:
uf(1) = 1;   % we just need a number bigger than 'toler', to be able to enter the "while"
% ('uf' is a vector that will contain the 'u(end)' values. At the moment this vector only has one element.)
iE = 0;  % index of 'E' vector
while ( abs( uf(end) - 0 ) > toler )   % the stopping condition is that 'u' is zero at "r=0"

    iE = iE + 1;
    
    % Do Numerov method with 'E(iE)':----------------------
    
    
    % define vector of 'g' values:
    for k=2:N   % starting from 2 because g(1) = inf
        g(k) = 2*E(iE) + 2/r(k) - l*(l+1)/(r(k)^2);
    end

    for k=N-1:-1:3       
        u(k-1) = (1 + h^2/12*g(k-1))^(-1) * ( 2*(1 - 5*h^2/12*g(k)) * u(k) - (1 + h^2/12*g(k+1)) * u(k+1) );
    end

    % need to interpolate to get u(1):
    u(1)=interp1(r(2:5), u(2:5), 0, 'spline');

    
    % ------------------------------------------------------------
    % plot current estimate of curve:
    figure(1)
    plot(r, u, 'r-');
    xlim([0,rmax]);
    umax = max(u);
    umin = min(u);
    du = umax - umin;
    ylim([umin - du*0.3, umax + du*0.3]);
    pause(0.1);   % pause the program for 1 second
    
    
    
    % store first element:
    uf(iE) = u(1);
    
    
    % make next guess for 'E':
    if(iE>1)
        slope = (uf(iE) - uf(iE-1)) / (E(iE) - E(iE-1));
        E(iE+1) = E(iE) + ( 0 - uf(iE) ) / slope;        
    end


end

E_num = E(end)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% normalize "u(r)":


% calculate square integral of 'u(r)':
I = trapz(r, u.^2);
u = u / sqrt(I);



% calculate radial wave function "R(r)" everywhere except for "r = 0":
R(2:N) = u(2:N)./r(2:N);
% interpolate to get R(1):
R(1) = interp1(r(2:5), R(2:5), 0, 'spline');


figure(2)
plot(r, R, 'r-');
title('normalized radial wave function');
xlim([0,rmax]);
Rmax = max(R);
Rmin = min(R);
dR = Rmax - Rmin;
ylim([Rmin - dR*0.3, Rmax + dR*0.3]);

hold on

% plot also exact form:
R_exact = -4*sqrt(2) / (27*sqrt(3)) * (1-r/6).*r.*exp(-r/3);   % n=3, l=1
plot(r,R_exact,'k--');











