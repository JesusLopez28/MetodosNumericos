clear
clc

opcion = 0;

while opcion ~= 10
    disp("------- MENÚ DE MÉTODOS NUMÉRICOS -------");
    disp("1. Bisección");
    disp("2. Falsa posición");
    disp("3. Newton-Raphson");
    disp("4. Punto Fijo")
    disp("5. Secante");
    disp("6. Muller");
    disp("7. Lagrange");
    disp("8. Aproximación polinomial simple");
    disp("9. Aproximación polinomial Newton");
    disp("10. Salir");
    disp("----------------------------------------");

    opcion = input("Ingresa el número correspondiente al método que deseas utilizar: ");

    switch opcion
        case 1
            disp("Has seleccionado Bisección.");
            biseccion();
            
        case 2
            disp("Has seleccionado Falsa posición.");
            falsaPosicion();
            
        case 3
            disp("Has seleccionado Newton-Raphson.");
            newtonRaphson();
        
        case 4
            disp("Has seleccionado Punto Fijo.");
            puntoFijo();

        case 5
            disp("Has seleccionado Secante.");
            secante();
            
        case 6
            disp("Has seleccionado Muller.");
            muller();
            
        case 7
            disp("Has seleccionado Lagrange.");
            lagrange();
            
        case 8
            disp("Has seleccionado Aproximación polinomial simple.");
            aproximacionPolinomialSimple();
            
        case 9
            disp("Has seleccionado Aproximación polinomial Newton.");
            aproximacionPolinomialNewton();
            
        case 10
            disp("Saliendo del programa...");
            
        otherwise
            disp("Opción no válida. Ingresa un número del 1 al 10.");
    end
    
    disp("Presiona cualquier tecla para continuar...");
    pause;
    clc;
end


function biseccion()
    % Código para el método de Bisección
    disp("Función Bisección");
end

function falsaPosicion()
    % Código para el método de Falsa posición
    disp("Función Falsa posición");
end

function newtonRaphson()
    % Código para el método de Newton-Raphson
    disp("Función Newton-Raphson");
end

function puntoFijo()
    clear
    clc
    disp('Método del punto fijo')
    syms x
    f =input('Introduzca la función f(x): ');
    xi =input('Introduzca el punto de inicio: ');
    err =input('Porcentaje de error: ');
    ezplot(f), grid on
    f =inline(f);
    j =0;
    ea =100;
    while err <= ea
        xr=f(xi);
        ea=abs(((xr-xi)/xr)*100);
        xi=xr;
        j=j+1;
    end
    fprintf('\nResultado de la raíz=%10.3f en %4d iteraciones\n',xr,j);
end

function secante()
    clear
    clc
    disp("Método de la Secante");
    f = input('Ingrese la función: ', 's');
    x1 = input('Ingrese el punto xi-1: ');
    x2 = input('Ingrese el punto xi: ');
    err = input('Ingrese el porcentaje de error: ');
    ezplot(f), grid on
    f = inline(f);
    ea = 100;
    i = 0;
    fprintf('Iteración:     Raíz:\n');
    while ea>err
        xi = x2-((f(x2)*(x1-x2))/(f(x1)-f(x2)));
        ea = abs(((xi-x2)/xi)*100);
        fprintf('   %f          %8.3f\n', i, x1);
        x1 = x2;
        x2 = xi;
        i = i+1;
    end
    fprintf('\nRaíz de la función=%12.6f\nCalculada en%4d iteraciones\n', xi, i);
end

function muller()
close all;
clear;
clc
disp("Método de Muller");
f = input('Ingrese la funcion: ');
x0 = input('Ingrese el valor de x0: ');
x1 = input('Ingrese el valor de x1: ');
x2 = input('Ingrese el valor de x2: ');
errorRelativo =  input('Ingrese el error permitido: ');

fx = inline(f);

k = 0;
xi = 0;
sigue = 1;


while(sigue)
    
    xi = x2;

    h0 = x1 - x0;
    h1 = x2 - x1;
    d0 = (fx(x1)-fx(x0))/(x1-x0);
    d1 = (fx(x2) - fx(x1))/(x2-x1);
    a = (d1-d0)/(h1+h0);
    b = (a.*h1) + d1;
    c = fx(x2);


    raizd = sqrt(b.*b - 4.*a.*c);

    if(abs(b+raizd) > abs(b-raizd))
        denominador = b+ raizd;
    else
        denominador = b - raizd;
    end


    dxr = (-2.*c)/denominador;
    x3 = x2 + dxr;
    
    errorActual = abs(x3 - x2)/x3;
    errorPorcentual = errorActual*100;
    %sigue = et < e;

    fprintf('\nIteracion: ');
    fprintf('%i',k);
    k = k+1;
    fprintf('\nxi: ');
    fprintf('%f',xi);

    fprintf('\nea: ');
    fprintf('%f',errorActual);
    fprintf('\n');


    if(errorActual < errorRelativo)
        break;
    end
    
    x0 = x1;
    x1 = x2;
    x2 = x3;       

end

end

function lagrange()
    % Código para el método de Lagrange
    disp("Función Lagrange");
end

function aproximacionPolinomialSimple()
    % Código para la Aproximación polinomial simple
    disp("Función Aproximación polinomial simple");
end

function aproximacionPolinomialNewton()
    % Código para la Aproximación polinomial Newton
    disp("Función Aproximación polinomial Newton");
end
