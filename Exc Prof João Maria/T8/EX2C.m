close
clear
clc

%Constantes
L=1;
h = 0.02;
L = 1;
M = 2*L/h + 1;
tol = 1e-7;



% set 'alpha' values to try:
alpha_suggested = 2 / (1 + pi/M);
alpha1 = 1.79;
alpha2 = 1.99;
Nalpha = 20;   % number of 'alpha' values I want to try
dalpha = (alpha2-alpha1) / (Nalpha-1);
alpha_vals = [alpha1:dalpha:alpha2];

%Vetores

x = [-L:h:L];
y = [-L:h:L];
[X,Y] = meshgrid(x,y);


%limites

lim=zeros(M,M);


lim(:,1) = 1;
lim(:,end) = 1;
lim(1,:) = 1;
lim(end,:) = 1;



%Outter
ind1 = floor( (M-1)/4 ) + 1;
ind2 = floor( (M-1)*3/4 ) + 1;
lim(ind1:ind2,ind1) = 1;
lim(ind1:ind2,ind2) = 1;
lim(ind1,ind1:ind2) = 1;
lim(ind2,ind1:ind2) = 1;


%Condições fronteira
Vold = zeros(M,M);

%Inner
ind1 = floor( (M-1)/4 ) + 1;
ind2 = floor( (M-1)*3/4 ) + 1;
Vold(ind1:ind2,ind1) = 1;
Vold(ind1:ind2,ind2) = 1;
Vold(ind1,ind1:ind2) = 1;
Vold(ind2,ind1:ind2) = 1;


Vnew=zeros(M,M);
diff=1;
cnt=0;


alpha_suggested = 2 / (1 + pi/M);
alpha1 = 1.79;
alpha2 = 1.99;
Nalpha = 20;   
dalpha = (alpha2-alpha1) / (Nalpha-1);
alpha_vals = [alpha1:dalpha:alpha2];

Vinit = Vold;


for k=1:Nalpha

    

    Vold = Vinit;
    Vnew = zeros(M,M);

    diff = 1;   
    count(k) = 0;  
    while (diff > tol)

        Vnew = Vold;
    
        for i=1:M
            for j=1:M
                if not(lim(i,j))  
                    Vnew(i,j) = alpha_vals(k) * (Vnew(i+1,j) + Vnew(i-1,j) + Vnew(i,j+1) + Vnew(i,j-1)) / 4;
                    Vnew(i,j) = Vnew(i,j) + ( 1 - alpha_vals(k) ) * Vold(i,j);
                else
                                    end
            end
        end
    
        diff = sqrt(sum(sum((Vnew - Vold).^2))) / sqrt(sum(sum(Vnew.^2)));
    
        Vold = Vnew;

        count(k) = count(k) + 1;

    end

   


end




figure(1)
mesh(X,Y,Vnew)

% plot convergence times for different 'alpha' values:
figure(2)
plot(alpha_vals, count, 'rs')
ylim([0, 500]);
hold on
plot([alpha_suggested, alpha_suggested], [0, 500], 'b-');
xlabel('\alpha');
ylabel('convergence time');


