function [r] = PolinomialSimple(x,y,X)

%x = vector en x
%y = vector fx
%X = Valor a interpolar

n = length(x);
A = (0);

for i = 1:n
    for j=1:n
        A(i,j) = power(x(i),(j-1));
    end
end

a=A\y';
%syms x real;
r = 0;
%for i = 1:n
 %   p(i) = a(i).*x.^(i-1);
%end

for i = 1:n
    r = r + a(i).*X.^(i-1);
end



