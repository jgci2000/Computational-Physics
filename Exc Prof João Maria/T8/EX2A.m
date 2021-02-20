close
clear
clc

%Constantes
L=1;
h = 0.05;
L = 1;
M = 2*L/h + 1;
tol = 1e-7;


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
count=0;

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

mesh(X,Y,Vnew)


