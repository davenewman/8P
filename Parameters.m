function [L,D,T,F_func,f,w,k,x,t,deltaT,lambda,g0,gL,nx,nt,X,Y,u_exact] = Parameters()
% This file holds parameters necessary to solve problem 1.
% Definitions: 

L = pi;                         % length of spacial domain
D = 0.1;                        % diffusion coefficient
T = 10;                         % total time interval
w = 1;                          % parameter specific to problem 2
k = 1;                          % wave number
nx = 10;                        % number of points discretizing x
nt = 10;                        % number of points discretizing t
x = linspace(0,L,nx+2);         % spatial domain
t = linspace(0,T,nt+2);         % time domain
deltaT = t(2) - t(1);           % delta T
f = sin(k*x);                   % initial condition
g0 = zeros(1,length(t));        % left boundary condition
gL = zeros(1,length(t));        % right boundary condition
[X,Y] = meshgrid(x,t);          % for plotting the analytical solution
u_exact = exp(-D*(k^2)*Y).*sin(k*X);   % analytical solution

% function handle for problem 2. For problem 1, this is all zeros
F_func = @(x,t) 0;

% lambda = D*deltaT/deltaX^2
lambda = D*deltaT/( (x(2) - x(1))^2 );

