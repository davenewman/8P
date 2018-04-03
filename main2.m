% solves problem 2
clear;
clc;
close all;

% nx and nt are the number of interior x points and t points, respectively
nx = 10;
nt = 100;

L = pi;
D = 0.1;
T = 10;
w = 10;
k = 1;

% equivalent to L/(n+1)
x = linspace(0,L,nx+2);
t = linspace(0,T,nt+2);
deltaT = t(2) - t(1);

lambda = D*deltaT/((x(2)-x(1))^2);

%initialize empty solution array u
u = zeros(length(t),length(x));

% initial condition
f = 0*ones(1,length(x));


% boundary conditions
g0 = sin(w*t);
gL = sin(w*t)*cos(k*L);

% arrange the grid with the boundary conditions
u(:,1) = g0;
u(:,end) = gL;
u(1,:) = f;


F_func = @(x,t) (w*cos(w*t) + D*k^2*sin(w*t))*cos(k*x);
F = F_func(x(2:length(x)-1),t(1));

f_right_side = CreateRightSide2(u(1,2:nx+1),lambda,g0(1),gL(1),F,deltaT)

% now we build the diagonal vectors with which we will solve the system
% here, "a" refers to the main diagonal, "b" refers to the lower diagonal,
% and "c" refers to the upper diagonal
a = (1+lambda)*ones(1,nx);
b = -0.5*lambda*ones(1,nx-1);
c = -0.5*lambda*ones(1,nx-1);

% this is the main solution loop
for i = 2:length(t)
    
    % this step solves for the u's at the new time step
    u(i,2:nx+1) = SolveTriDiag(a,b,c,f_right_side);
    
    % and now we update the right hand side of the equation for the next
    % time step
    F = F_func(x(2:length(x)-1),t(i));
    f_right_side = CreateRightSide2(u(i,2:nx+1),lambda,g0(i),gL(i),F,deltaT);
end
  
%checking against analytical solution
[X,Y] = meshgrid(x,t);
u_exact = sin(w*Y).*cos(k*X)
figure;
surf(X,Y,u_exact);
xlabel('x'),ylabel('t');
figure;
surf(X,Y,u);
xlabel('x'),ylabel('t');
