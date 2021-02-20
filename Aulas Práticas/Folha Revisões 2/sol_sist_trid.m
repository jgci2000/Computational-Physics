function y=sol_sist_trid(A,B)

% Encontra as solucoes y para um sistema de equacoes
% do tipo A y = B, onde A e' uma matriz tridiagonal

A_tri=A; 
b_tri=B;

n_tri=numel(b_tri);
d_tri=diag(A_tri);
c_tri=[diag(A_tri,1); 0];
a_tri=[0; diag(A_tri,-1)];

h_tri(1)=c_tri(1)/d_tri(1);
p_tri(1)=b_tri(1)/d_tri(1);

for i=2:n_tri
    h_tri(i)=c_tri(i)/(d_tri(i)-a_tri(i)*h_tri(i-1));
    p_tri(i)=(b_tri(i)-a_tri(i)*p_tri(i-1))/(d_tri(i)-a_tri(i)*h_tri(i-1));
end

y(n_tri)=p_tri(n_tri);
for i=n_tri-1:-1:1
    y(i)=p_tri(i)-h_tri(i)*y(i+1);
end



