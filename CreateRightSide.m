function [f] = CreateRightSide(u,lambda,g0,gL,F,deltaT)
% creates the right hand side (f) of the equation for each new time step based
% on the results of the previous time step. g0 is the left boundary
% condition, gL is the right boundary condition. F is zero for problem 1 
% and non-zero for problem 2.
% Note that the right side only needs to be created for the interior points. 
f = zeros(1,length(u));

f(1) = lambda*g0 + (1-lambda)*u(1) + 0.5*lambda*u(2);
for k = 2:length(f) - 1
    f(k) = 0.5*lambda*u(k-1) + (1-lambda)*u(k) + 0.5*lambda*u(k+1);
end

f(end) = 0.5*lambda*u(k) + (1-lambda)*u(k+1) + lambda*gL;

f = f + deltaT*F;
