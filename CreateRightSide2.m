function [f] = CreateRightSide2(u,lambda,g0,gL,F,deltaT)
% creates the right hand side of the equation for each new time step based
% on the results of the previous time step

f = zeros(1,length(u));

f(1) = lambda*g0 + (1-lambda)*u(1) + 0.5*lambda*u(2);
for k = 2:length(f) - 1
    f(k) = 0.5*lambda*u(k-1) + (1-lambda)*u(k) + 0.5*lambda*u(k+1);
end

f(end) = 0.5*lambda*u(k) + (1-lambda)*u(k+1) + lambda*gL;

f = f + deltaT*F