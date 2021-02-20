clear
clc

% Constantes:
h = 0.025; 
tol = 1e-7;   
L = 1;   

M = 2*L/h + 1;

x = [-L:h:L];
y = [-L:h:L];
[X,Y] = meshgrid(x,y);


lim = zeros(M,M);

% outside 
lim(:,1) = 1;
lim(:,end) = 1;
lim(1,:) = 1;
lim(end,:) = 1;

% inside
ind1 = floor( (M-1)/4 ) + 1;
ind2 = floor( (M-1)*3/4 ) + 1;
lim(ind1:ind2,ind1) = 1;
lim(ind1:ind2,ind2) = 1;
lim(ind1,ind1:ind2) = 1;
lim(ind2,ind1:ind2) = 1;

Vold = zeros(M,M);


ind1 = floor( (M-1)/4 ) + 1;
ind2 = floor( (M-1)*3/4 ) + 1;
Vold(ind1:ind2,ind1) = 1;
Vold(ind1:ind2,ind2) = 1;
Vold(ind1,ind1:ind2) = 1;
Vold(ind2,ind1:ind2) = 1;



Vnew = zeros(M,M);

diff = 1;   
count = 0;  
while (diff > tol)

    for i=1:M
        for j=1:M
            if not(lim(i,j))  
                Vnew(i,j) = (Vold(i+1,j) + Vold(i-1,j) + Vold(i,j+1) + Vold(i,j-1)) / 4;
            else
                Vnew(i,j) = Vold(i,j);
            end
        end
    end
    
    diff = sqrt(sum(sum((Vnew - Vold).^2))) / sqrt(sum(sum(Vnew.^2)));
    

    Vold = Vnew;

   
    count = count + 1;

end

count

figure(1)
mesh(X,Y,Vnew)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ELETRO IS FUUUUNNNNN LEITÃO SENPAI PLS NOTICE ME :)))))

[Ex,Ey] = gradient(Vnew,h,h);
Ex = -Ex;
Ey = -Ey;
figure(2)
quiver(X,Y,Ex,Ey)



Cap_1 = -trapz(x,Ex(:,1)) * 4

E2 = Ex.^2 + Ey.^2;
Cap_2 = mean(mean(E2)) * 4


