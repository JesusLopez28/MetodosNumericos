%LAGRANJA
function [r] = Lagrange(x,y,X)
%x= vector en x
%y = vector en y
%n = grado del polinomio
%X = Coordenada a encontrar

n1=length(x);
num=n1-1;
L=zeros(n1,n1);
for k=1:num+1
    V=1;
    for j=1:num+1
        if k~=j
            V=conv(V,poly(x(j)))/(x(k)-x(j));
        end
    end
    L(k,:)=V;
end
C=y*L;
n = length(x); %numero de elementos en el arreglo
pot = length(x) -1; %potencia maxima del polinomio
r = 0; %Variable para guardar el resultado
for i = 1:n
    pot = pot - 1;
    r = r + C(1,i).*power(X,pot);
end


