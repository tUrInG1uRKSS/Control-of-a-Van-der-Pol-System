clear all, close all
syms x y u
mu = 0.1;
dxdt = [y; -x+mu*(1-x^2)*y+u];
xe = 0;
ye = 0;
ue = 0;
A= jacobian(dxdt,[x;y]);
A = double(subs(A,[x;y;u],[xe;ye;ue]));
B = jacobian(dxdt,u);
B = double(subs(B,[x;y;u],[xe;ye;ue]));
Q = diag([100 100]);
R = 1;
K = lqr(A,B,Q,R)
u = -K*[x;y];
eval(dxdt)
Q2 = Q;
P = lyap((A-B*K)',Q2);

V = 1/2*[x;y].'*P*[x;y];
dV = jacobian(V,[x;y])*dxdt;
dV = eval(dV);

figure
% ezplot(V-1); grid on; hold on;
% ezplot(V-2);
% ezplot(V-24.75);
ezplot(dV-0);

J=matlabFunction(V);
dVFunction=matlabFunction(dV);

x0=[2.1;0.85];%condicion inicial
[xmin,valmin]=fmincon(@(x)J(x(1),x(2)),x0,[],[],[],[],[],[],@(x)restr(x,dVFunction(x(1),x(2))))
ezplot(V-valmin)
function [c,ceq]=restr(x,dV) %c<=0  ceq==0
    rtol=0.3;
    c=rtol^2-x(1)^2-x(2)^2;
    ceq=dV;
end