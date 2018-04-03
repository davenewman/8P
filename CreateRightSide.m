function [f] = CreateRightSide(u,lambda,g0,gL)
% creates the right hand side of the equation for each new time step based
% on the results of the previous time step

f = zeros(length(u) - 2);

f(1) = g0(1) + 0.5*u(1);
for k = 2:length(f) - 1
    f(k) = 0.5*lambda*u(k-1) + (1-lambda)*u(k) + 0.5*lambda*u(k+1);
end

f(end) = gL(end) + 0.5*lambda*u(end);
