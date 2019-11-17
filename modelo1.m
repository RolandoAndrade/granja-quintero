model = input("Modelo N° => ")

%Esta medio cochino pero no me juzgues Rolando lol

%Coeficientes de la funcion objetivo segun el modelo elegido
switch (model)
  case 1
    c = [70 0.35 57.3 48.9 33.15];
  case 2
    c = [70 0.35 -22.7 -11.1 -21.85];
  case 3
    c = [70 0.35 2.3 8.9 3.15];
  case 4
    c = [70 0.35 37.3 28.9 23.15];
  case 5
    c = [70 0.35 -27.7 -31.1 -16.85];
  case 6
    c = [70 0.35 -2.7 -1.1 -1.85];
  case 7
    c = [70 0.35 21.3 16.4 13.9];
endswitch




%sujeto a:

%Matriz de coeficientes de restricciones
A=[ 1,0,0,0,0 ; 1,0,0,0,0 ; 0,1,0,0,0 ; 0,1,0,0,0 ; -1,0,0,1,0 ; 0,-0.05,0,0,1; 2,0,1,1,1 ; 1500, 3,0,0,0; 60, 0.3, 1, 0.9, 0.6; 60,0.3,1.4,1.2,0.7];

%Lado derecho de las restricciones 
b=[30;42;2000;5000;0;0;640;71000;4000;4500];

%Limite inferior = 0
lb=[0;0;0;0;0];

%Limite superior = infinito
ub=[Inf;Inf;Inf;Inf;Inf];

%Tipo de cada restriccion (menor o igual, mayor o igual)
ctype = ["L";"U";"L";"U";"L";"L";"U";"U";"U";"U"];

%Tipo de cada variable (continua o entera)
vtype = ["I";"I";"C";"C";"C"];

%Maximizar = -1
sense=-1;

[x,zmx]=glpk(c,A,b,lb,ub,ctype,vtype,sense);

printf("Resultados:\n");
printf(" Z = %.3f \n V = %i \n G = %i \n S = %i \n M = %i \n T = %i \n",zmx+66000,x(1),x(2),x(3),x(4),x(5))

printf("Adicionales:\n");
printf("Acres ocupados: %.3f \n", 2*x(1) + x(3) + x(4) + x(5)); 
printf("Acres sin uso: %.3f \n", 640 - 2*x(1) - x(3) - x(4) - x(5) ); 
printf("Acres de maíz dedicados a las vacas: %.3f \n", 2*x(1));
printf("Valor de los animales a final de año: %.3f\n", 0.9*(35000 + 1500 *(x(1)-30)) + 0.75*(5000 + 3*(x(2)-2000)) );
printf("Inversion en compra de vacas: %.3f\n", 1500 *(x(1) - 30) );
printf("Inversion en compra de gallinas: %.3f \n", 3 *(x(2) - 2000) );
printf("Dinero restante de inversion inicial: %.3f \n", 20000 - 1500 *(x(1) - 30)  -3 *(x(2) - 2000));
printf("Horas hombre consumidas (primavera e invierno): %.3f \n", 4000- x(3) - 0.9*x(4) - 0.6*x(5) - 60*x(1) - 0.3 * x(2));
printf("Horas hombre consumidas (verano y otoño): %.3f \n", 4500 - 1.4 * x(3) - 1.2*x(4) - 0.7*x(5) - 60*x(1) - 0.3 * x(2));
printf("Ingreso por trabajo en granja vecina (primavera e invierno): %.3f \n", 5* (4000- x(3) - 0.9*x(4) - 0.6*x(5) - 60*x(1) - 0.3 * x(2))  );
printf("Ingreso por trabajo en granja vecina (verano y otoño): %.3f \n", 5.5* (4500 - 1.4 * x(3) - 1.2*x(4) - 0.7*x(5) - 60*x(1) - 0.3 * x(2)) );


printf("Ingreso por cosechas: ");
switch (model)
  case 1
    printf("%.3f \n", 70*x(3) + 60 * x(4) + 40 * x(5));
  case 2
    printf("%.3f \n", -10*x(3) + -15* x(4) + 0 * x(5));
  case 3
    printf("%.3f \n", 15*x(3) + 20* x(4) + 10* x(5));
  case 4
    printf("%.3f \n", 50*x(3) + 40* x(4) + 30 * x(5));
  case 5
    printf("%.3f \n", -15*x(3) + -20* x(4) + -10 * x(5));
  case 6
    printf("%.3f \n", 10*x(3) + 10* x(4) + 5* x(5));
  case 7
    printf("%.3f \n", 34*x(3) + 27.5* x(4) + 20.75 * x(5));
endswitch


