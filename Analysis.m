function [] = Analysis(X,Y,x,u,u_exact,nx)

figure;
surf(X,Y,u_exact);
xlabel('x'),ylabel('t'),title('Exact Solution');

figure;
surf(X,Y,u);
xlabel('x'),ylabel('t'),title('Crank-Nicolson Scheme');

% plots for t = T/5, T/2, and T
figure;
plot(x,u(end/5,:),x,u_exact(end/5,:));
xlabel('x'),ylabel('u(x,T/5)'),title('Comparison at t = T/5');
legend('Crank-Nicolson','Analytical');

figure;
plot(x,u(end/2,:),x,u_exact(end/2,:));
xlabel('x'),ylabel('u(x,T/2)'),title('Comparison at t = T/2');
legend('Crank-Nicolson','Analytical');

figure;
plot(x,u(end,:),x,u_exact(end,:));
xlabel('x'),ylabel('u(x,T)'),title('Comparison at t = T');
legend('Crank-Nicolson','Analytical');

error = (1/nx)*sum( abs( (u(end,2:nx+1) - u_exact(end,2:nx+1))./u_exact(end,2:nx+1) ) );
fprintf('Average error for solution at last time step: %.15f\n',error);