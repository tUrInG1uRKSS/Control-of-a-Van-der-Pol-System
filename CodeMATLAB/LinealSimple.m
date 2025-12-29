clc; clear all; close all;
%% LinealizacionSimple
syms x1 x2 u t
x = [x1;x2];
xd = [1;0];
A = jacobian(vdp(t,x,@(x)0),x);
A = double(subs(A,x,xd));
B = jacobian(vdp(t,x,@(x)u),u);
B = double(subs(B,x,xd));
C = [1 0];
D = [0];
[num, den] = ss2tf(A,B,C,0);
G = tf(num,den)

%% Definicion de K
% Se puede obtener un K por LQR
% Q = diag([1000 10]);
% R = 1;
% K = lqr(A,B,Q,R)
% ... o se puede probar con un K cualquiera
% que cumpla los requerimientos
K = [5 5];

%% Simulacion
[T,X] = ode45(@(t,x)vdp(t,x,controlLQR(t,x,K)), [0 10], [0;0]);

U = zeros(length(T), 1);

% Calcular los valores de u
for i = 1:length(T)
    U(i) = controlLQR(T(i), X(i, :)',K);
end


figure(1)
plot(T,X(:,1)); hold on;
plot(T,X(:,2));
legend('x1', 'x2');
figure(2)
plot(X(:,1),X(:,2))
figure(3)
plot(T, U)
title('Salida de la función control')
xlabel('Tiempo (s)')
ylabel('Control u')

%% Funcion de Control
function u = controlLQR(t,x,K)
    u = 1-K*[x(1)-1; x(2)]
end

%% Dinamica del Sistema
function dxdt = vdp(t,x,u)
    mu = 0.1;
    dxdt = [x(2); -x(1)+mu*(1-(x(1)^2))*x(2)+u];
end