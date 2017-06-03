% Using fixed point method to solve nonlinear equation within 10^(-5) with 
% infinite norm.
% x1 = x2/sqrt(5);
% x2 = 0.25*(sin(x1)+cos(x2))
% 
% Author: Jinlong Huang

x = zeros(2,30);

x(:,1) = [1/4;1/4];

for i = 1:30
    x(1,i+1) = x(2,i)/sqrt(5);
    x(2,i+1) = 0.25*(sin(x(1,i))+cos(x(2,i)));
    tol = max(abs(x(1,i+1)-x(1,i)), abs(x(2,i+1)-x(2,i)));
    fprintf(1,'x1 is %6.4f, x2 is %6.4f, tol is %2.2e\n', x(1,i+1), x(2,i+1), tol)
    if tol <= 10^(-5)
        fprintf(1,'Number of iteration is %d\n', i);
        fprintf(1, '\n');
        break;
    end 
end

x = zeros(2,30);

x(:,1) = [1/4;1/4];

% accelaarte similar to Gauss-Seidel
for i = 1:30
    x(1,i+1) = x(2,i)/sqrt(5);
    x(2,i+1) = 0.25*(sin(x(1,i+1))+cos(x(2,i)));
    tol = max(abs(x(1,i+1)-x(1,i)), abs(x(2,i+1)-x(2,i)));
    fprintf(1,'x1 is %6.4f, x2 is %6.4f, tol is %2.2e\n', x(1,i+1), x(2,i+1), tol)
    if tol <= 10^(-5)
        fprintf(1,'Number of iteration is %d\n', i);        
        break;
    end 
end


