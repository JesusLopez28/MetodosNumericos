function [Y,NewtonPol,M] = NewtonInt(x,y,n,X)

% ESTA FUNCION PIDE LOS SIGUIENTES DATOS DE ENTRADA:

% x = Vector de coordenadas en x
% y = Vector de coordenadas en y
% n = Grado del polinomio a crear
% X = Coordenada para evaluar en el polinomio de interpolación

% VARIABLES DE SALIDA:

% Y = Valor del polinomio creado evaluado en X
% NewtonPol = Polinomio de Newton creado como un string.
% M = Tabla con los valores interpolados para cada grado del polinomio y
%     con los errores aproximados correspondientes.


%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Algoritmo~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%

%Construir la matriz de diferencias divididas finitas
diferenciasDivididas = zeros(length(x),length(y)); diferenciasDivididas(:,1) = y;
for j = 2:n+1
    for i = 1:(n+1)-(j-1)
        diferenciasDivididas(i,j) = (diferenciasDivididas(i+1,j-1) - diferenciasDivididas(i,j-1)) / (x(i+j-1) - x(i));
    end
end

%Interpolación de Newton
xterm = 1; yint = diferenciasDivididas(1,1); yacum = 0;
for i = 2:n+1
    xterm = xterm*(X-x(i-1));
    yint(i) = diferenciasDivididas(1,i)*xterm;
    yacum(i) = yacum(i-1) + yint(i);
    ea(i) = yacum(i) - yacum(i-1);
end
Y = sum(yint);

%Construir el polinomio de Newton como un string
pol{1,1} = num2str(diferenciasDivididas(1,1));
if n == 0
    NewtonPol = cell2mat(pol);
else
    for i = 2:n+1
        if sign(x(i)) == 1
            xr{1,i} = ['*(x - ',num2str(x(i-1)),')'];            
        elseif sign(x(i)) == -1
            xr{1,i} = ['*(x + ',num2str(x(i-1)),')'];
        end
        if sign(diferenciasDivididas(1,i)) == 1
            pol{1,i} = cell2mat([' +',num2str(diferenciasDivididas(1,i)),xr(2:end)]);
        elseif sign(diferenciasDivididas(1,i)) == -1
            pol{1,i} = cell2mat([' ',num2str(diferenciasDivididas(1,i)),xr(2:end)]);
        end
    end
    NewtonPol = cell2mat(pol);
end

%Resumen en una tabla
disp(['Interpolación con x = ', num2str(X)]);
vn = 0:n;
Encabezado = {'Grado','P(x)','Error'};
Datos = num2cell([vn',yacum',ea']);
M = [Encabezado ; Datos];