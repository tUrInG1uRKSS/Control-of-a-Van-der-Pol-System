clc; clear all; close all;
%% Simulacion
[T,X] = ode45(@(t,x)vdp(t,x), [0 100], [3;0]);

figure(1)
plot(T,X(:,1)); hold on;
plot(T,X(:,2));
legend('x1', 'x2');
figure(2)
plot(X(:,1),X(:,2))
%% Dinamica de Van der Pol
function dxdt = vdp(t,x)
    u = 0;
    mu = 0.1;
    dxdt = [x(2); -x(1)+mu*(1-(x(1)^2/10))*x(2)+u];
end