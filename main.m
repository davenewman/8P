% Created by David Newman, PeopleSoft ID 1441532
% Main script for the solution of problem 8P

clear;
clc;
close all;

% Parameters is for problem 1, Parameters2 is for problem 2.
% uncomment the necessary line to solve the problem you wish.

%[L,D,T,F_func,f,w,k,x,t,deltaT,lambda,g0,gL,nx,nt,X,Y,u_exact] = Parameters();
[L,D,T,F_func,f,w,k,x,t,deltaT,lambda,g0,gL,nx,nt,X,Y,u_exact] = Parameters2();

% initialize empty solution array u (preallocate)
u = zeros(length(t),length(x));

% arrange the solution grid with the boundary conditions
u(:,1) = g0;
u(:,end) = gL;
u(1,:) = f;

% now we build the diagonal vectors with which we will solve the system
% here, "a" refers to the main diagonal, "b" refers to the lower diagonal,
% and "c" refers to the upper diagonal
a = (1+lambda)*ones(1,nx);
b = -0.5*lambda*ones(1,nx-1);
c = -0.5*lambda*ones(1,nx-1);

% this is the main solution loop
for i = 2:length(t)
    
    F = F_func(x(2:length(x)-1),t(i-1));
    f_right_side = CreateRightSide(u(i-1,2:nx+1),lambda,g0(i-1:i),gL(i-1:i),F,deltaT);
    
    % this step solves for the u's at the new time step
    u(i,2:nx+1) = SolveTriDiag(a,b,c,f_right_side);
    
    % and now we update the right hand side of the equation for the next
    % time step
    
end

%checking against analytical solution
Analysis(X,Y,x,u,u_exact,nx);
