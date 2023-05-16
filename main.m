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
            biseccion();
            
        case 2
            falsaPosicion();
            
        case 3
            newtonRaphson();
        
        case 4
            puntoFijo();

        case 5
            secante();
            
        case 6
            muller();
            
        case 7
            lagrange();
            
        case 8
            aproximacionPolinomialSimple();
            
        case 9
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
    clear
    clc
    disp('Método de la bisección')
    f = input('Introduzca la función f(x):', 's');
    xa = input('Introduzca el valor de Xa: ');
    xb = input('Introduzca el valor de Xb: ');
    err = input('Porcentaje de error: ');

    f = inline(f, 'x');
    erro = 100;
    xr = 0;
    i = 0;

    if f(xa)*f(xb) < 0
        while erro > err
            i = i + 1;
            ea = xr;
            xr = (xa + xb) / 2;
            if f(xa) * f(xr) > 0
                xa = xr;
            else
                xb = xr;
            end
            erro = abs(((ea - xr) / xr) * 100);
        end
        fprintf('\nRaíz = %10.3f en %4d iteraciones\n', xr, i);
    else
        fprintf('No existe raíz en el intervalo dado.\n');
    end
end


function falsaPosicion()
    clear
    clc 
    disp('Método de la Falsa Posición')
    f = input('Introduzca la función f(x):', 's');
    xa = input('Introduzca el valor de Xa: ');
    xb = input('Introduzca el valor de Xb: ');
    err = input('Porcentaje de error: ');

    f = inline(f, 'x');
    erro = 100;
    xr = 0;
    i = 0;

    if f(xa) * f(xb) < 0
        while erro > err
            ea = xr;
            xr = xb - ((f(xb) * (xa - xb)) / (f(xa) - f(xb)));
            if f(xa) * f(xr) > 0
                xa = xr;
            else
                xb = xr;
            end
            erro = abs(((ea - xr) / xr) * 100);
            i = i + 1;
        end
        fprintf('\nResultado de la raíz = %10.3f en %4d iteraciones\n', xr, i);
    else
        fprintf('No existe raíz en el intervalo dado.\n');
    end
end


function newtonRaphson()
    clear
    clc
    disp('Método de Newton Raphson')
    
    f_str = input('Introduzca la función f(x):', 's');
    f = @(x) eval(f_str);
    
    pi = input('Introduzca el punto de inicio:');
    err = input('Porcentaje de error:');

    df = @(x) (f(x+0.0001) - f(x)) / 0.0001;
    df2 = @(x) (df(x+0.0001) - df(x)) / 0.0001;
    
    ea = 100;
    j = 0;

    while ea > err
        xi = pi - (f(pi) * df(pi)) / ((df(pi)^2) - (f(pi) * df2(pi)));
        ea = abs(((xi - pi) / xi) * 100);
        pi = xi;
        j = j + 1;
    end

    fprintf('\nResultado de la raíz = %10.3f en %4d iteraciones\n', pi, j);
end



function puntoFijo()
    clear
    clc
    disp('Método del punto fijo')
    f = input('Introduzca la función f(x): ', 's');
    xi = input('Introduzca el punto de inicio: ');
    err = input('Porcentaje de error: ');
    f = inline(f, 'x');
    j = 0;
    ea = 100;

    while err <= ea
        xr = f(xi);
        ea = abs(((xr - xi) / xr) * 100);
        xi = xr;
        j = j + 1;
    end

    fprintf('\nResultado de la raíz = %10.3f en %4d iteraciones\n', xr, j);
end


function secante()
    clear
    clc
    disp("Método de la Secante");
    f = input('Ingrese la función: ', 's');
    x1 = input('Ingrese el punto xi-1: ');
    x2 = input('Ingrese el punto xi: ');
    err = input('Ingrese el porcentaje de error: ');
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
    clear
    clc
    x = input('Ingrese el vector x: ');
    fx = input('Ingrese el vector fx: ');
    X = input('Ingrese la coordenada a evaluar en el polinomio: ');
    z = Lagrange(x,fx,X);
    fprintf('%f', z);
    fprintf('\n');
end

function aproximacionPolinomialSimple()
    x = input('Ingrese el vector x: ');
    fx = input('Ingrese el vector fx: ');
    X = input('Ingrese la coordenada a evaluar en el polinomio: ');
    z = PolinomialSimple(x,fx,X);
    fprintf('%s', z);
    fprintf('\n');
    disp("Aproximacion Polinomial Simple");

end

function aproximacionPolinomialNewton()
    clear
    clc
    disp("Interpolación Polinomial de Newton");
    x = input('Ingrese el vector x: ');
    fx = input('Ingrese el vector fx: ');
    grado = input('Ingrese el grado del polinomio a crear: ');
    X = input('Ingrese la coordenada a evaluar en el polinomio: ');
    z = NewtonInt(x,fx,grado,X);
    fprintf('%f', z);
    fprintf('\n');
    disp("Función Aproximación polinomial Newton");
end
