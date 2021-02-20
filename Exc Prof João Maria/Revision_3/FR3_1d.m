% Program to study relaxation methods when solving the Poisson equation
% (over-relaxation method)
% (how the convergence time depends on the number of points "M" along one dimension)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
clc

% parameters:
L = 1;
toler = 1e-7;   % tolerance to determine convergence

% define vector of "M" values:
Mvals = [71:20:171];
nM = length(Mvals);

% define function "q(x,y)":
q = @(x, y) 2 * (2 - x.^2 - y.^2);

% loop over different values of "M":
for iM=1:nM

    
    M = Mvals(iM)
    
    
    % generate list of "alpha" candidates for this "M" value:
    alfa_rec = 2 - 2*pi/M;
    alphavals = linspace(alfa_rec * 0.96 + 0.08, alfa_rec * 0.94 + 0.12, 10);
    na = length(alphavals);
    
    % create a grid of points:
    x = linspace(-L, L, M);
    y = linspace(-L, L, M);
    [X, Y] = meshgrid(x,y);
    h = 2 * L / (M-1);
    
    % generate matrix of "f" values:
    f = -q(X,Y);

    
    clear cntnow;   % this vector will store the number of iterations for a given "alpha"
    
    
    % loop over different values of "alpha":
    for ia=1:na
    
    
        alpha = alphavals(ia);
        
         
        % initial estimate:
        Told = zeros(M,M);
    
    
        % Do iterative method:
        Tnew = zeros(M,M);   % to create the matrix "Tnew"

        reldiff = 1;   % could be any value bigger than 'toler'
        cnt = 0;  % counter
    
        Tnew = Told;   % for Gauss-Seidel
        while (reldiff > toler)

            % update only for non-boundary points:
            for i=2:M-1
                for j=2:M-1
                    Tnew(i,j) = (1-alpha)*Told(i,j) + alpha*(Tnew(i+1,j) + Tnew(i-1,j) + Tnew(i,j+1) + Tnew(i,j-1) - h^2*f(i,j)) / 4;
                end
            end
    
            % calculate 'reldiff':
            reldiff = sqrt(sum(sum((Tnew - Told).^2))) / sqrt(sum(sum(Tnew.^2)));
    
            % update 'Told':
            Told = Tnew;

            % increment counter:
            cnt = cnt + 1;

        end

        cntnow(ia) = cnt;
    
    
    
    end   % end of loop over "alpha" values
    
    
    
    cntvals(iM) = min(cntnow);

    

end   % end of loop over "M" values

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% plot temperatures from last value of "M":

figure(1)
mesh(x, y, Tnew')
xlim([-L, L])
ylim([-L, L])
xlabel('x')
ylabel('y')
zlabel('T')

% plot log of "cnt" as a function of log of "M":
% (to verify the expected behaviour "cnt ~ M" - using the optimal alpha)
figure(2)
plot(log(Mvals),log(cntvals),'rs-')
hold on
lr = polyfit(log(Mvals), log(cntvals), 1);
display(['slope = ', num2str(lr(1))])
xlabel('ln M')
ylabel('ln (Number of iterations)')


% the true optimal "alpha" produces even faster convergence with
% more-or-less the same dependence on M: "cnt ~ M"
% (if we increased "M" the true optimal alpha would approach the value "alpha = 2 - 2*pi/M")

















