clear;
clc;

% nx and nt are the number of interior x points and t points, respectively

nx = 10;
nt = 10;

L = pi;
D = 0.1;
T = 10;
F = 0;

% equivalent to L/(n+1)
x = linspace(0,L,nx+2);
t = linspace(0,T,nt+2);

lambda = D*(t(2)-t(1))/((x(2)-x(1))^2);

%initialize empty solution array u
u = zeros(length(t),length(x));

% initial condition
k = 1;
f = sin(k*x);

% boundary conditions
g0 = 0*ones(1,length(t));
gL = 0*ones(1,length(t));

% arrange the grid with the boundary conditions
u(:,1) = g0;
u(:,end) = gL;
u(1,:) = f;

f_right_side = CreateRightSide(u(1,:),lambda,g0,gL);

% now we build the diagonal vectors with which we will solve the system
% here, "a" refers to the main diagonal, "b" refers to the lower diagonal,
% and "c" refers to the upper diagonal
a = (1-lambda)*ones(1,nx);
b = -0.5*lambda*ones(1,nx-1);
c = -0.5*lambda*ones(1,nx-1);

% this is the main solution loop
for i = 2:length(t)
    
    % this step solves for the u's at the new time step
    u(i,2:nx+1) = SolveTriDiag(a,b,c,f_right_side);
    
    % and now we update the right hand side of the equation for the next
    % time step
    f_right_side = CreateRightSide(u(i,:),lambda,g0,gL);
end
  
