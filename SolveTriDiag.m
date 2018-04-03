function [ u ] = SolveTriDiag(a,b,c,f)
%This function solves the tri-diagonal systems directly using the Thomas
%algorithm. "a" refers to the main diagonal, "b" refers to the lower
%diagonal, and "c" refers to the upper diagonal. "f" is the known right
%hand side. All inputs are in the form of vectors.

u = zeros(length(f),1);

for i = 2:length(f)
    a(i) = a(i) - (1/a(i-1))*b(i-1)*c(i-1);
    f(i) = f(i) - (1/a(i-1))*b(i-1)*f(i-1);
end

u(i) = f(i)/a(i);

for k = length(f) - 1:-1:1
    u(k) = (1/a(k))*(f(k) - c(k)*u(k+1));
end

end

