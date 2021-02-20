close all
clear all
clc

tol=1e-7;
N=8;
alpha = 1.25;

%Criar Matriz A

norm=sqrt(2)/2;
A=zeros(8,8);

for i=1:8
    A(i,i)=-1;
end
A(1,4)=norm;
A(1,5)=1;
A(2,4)=norm;
A(3,7)=0.5;
A(4,4)=-1*norm;
A(4,6)=-1;
A(4,7)=0.5;
A(5,8)=1;
A(6,6)=1;
A(7,4)=-1*norm;
A(7,7)=sqrt(3)/2;
A(8,7)=-sqrt(3)/2;

%Criar Matriz B
b=zeros(N,1);
b(6)=10000;

%Guess inicias
xold = ones(N,1);
xnew = zeros(N,1);

maxdiff=1;
count=0;



while (maxdiff > tol)
    
    xnew = xold;
    
    for i=1:N  
        aux = 0;
        for j=1:N
            aux = aux - A(i,j) * xnew(j);
        end
        
        aux = (aux + A(i,i) * xnew(i) + b(i)) / A(i,i);
        
        xnew(i) = alpha * aux + (1-alpha) * xold(i);  
        
    end

   
    maxdiff = max(abs(xnew-xold)) / max(abs(xold));
    
 
    xold = xnew;
    
    count = count + 1;

end

x_exact = linsolve(A,b);
xnew



