function [] = Analysis(X,Y,x,u,u_exact,nx)

figure;
surf(X,Y,u_exact);
xlabel('x'),ylabel('t'),title('Exact Solution');

figure;
surf(X,Y,u);
xlabel('x'),ylabel('t'),title('Crank-Nicolson Scheme');

figure;
plot(x,u(end,:),x,u_exact(end,:));

error = (1/nx)*sum( abs( (u(end,2:nx+1) - u_exact(end,2:nx+1))./u_exact(end,2:nx+1) ) );
fprintf('Average error for solution at last time step: %.15f\n',error);