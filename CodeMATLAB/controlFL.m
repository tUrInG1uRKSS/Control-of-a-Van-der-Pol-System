 clc, clear all, close all
%% Hallar v para FL
syms x1 x2 t u v
x = [x1;x2];
dxdt = vdp(t,x,u);
y = x1; % se define salida
dy = jacobian(y,x)*dxdt;
ddy = jacobian(dy,x)*dxdt;
Sol = solve(ddy == v, u)

%% Simulacion
[T,X] = ode45(@(t,x)vdp(t,x,control(t,x,Sol)), [0 10], [0;0]);

% Inicializar vector para almacenar los valores de u
U = zeros(length(T), 1);

% Calcular los valores de u
for i = 1:length(T)
    U(i) = control(T(i), X(i, :)', Sol);
end

figure(1)
plot(T,X(:,1)); hold on;
plot(T,X(:,2));
legend('x1', 'x2');
title('Estados x1 y x2')
xlabel('Tiempo (s)')
ylabel('Estados')

figure(2)
plot(X(:,1),X(:,2))
title('Trayectoria en el espacio de estados')
xlabel('x1')
ylabel('x2')

figure(3)
plot(T, U)
title('Salida de la función control')
xlabel('Tiempo (s)')
ylabel('Control u')

%% Funcion de controlFL
function u = control(t,x,Sol)
    x1 = x(1); x2 = x(2);
    y = x1;
    dy = x(2); % dx1 = x2
    yd = 1;
    dyd = 0;
    vd = 0;
    kp = 9;
    kd = 3;
    v = vd-kp*(y-yd)-kd*(dy-dyd);
    u = double(eval(Sol));
end
%% Dinamica de Van der Pol
function dxdt = vdp(t,x,u)
    mu = 0.1;
    dxdt = [x(2); -x(1)+mu*(1-x(1)^2)*x(2)+u];
end