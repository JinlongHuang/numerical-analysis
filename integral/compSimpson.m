% initialize
F = @compositeSimpson;
FP = @(x) 1/sqrt(2*pi)*exp(-x^2/2);
P0 = 0.5;   
TOL = 10^(-5);
OK = 1;
NO = 30;    % max number of iteration
fprintf(1, 'Newtons Method Using Simpson Rule with N = 10\n');
fprintf(1, '  I   P                 F(P)\n');
F0 = F(P0);

% Start iteration
I = 1;     
while I <= NO && OK == 1
D = F0/FP(P0);
P0 = P0 - D;  
F0 = F(P0);
fprintf(1,'%3d   %14.8e   %14.7e\n',I,P0,F0);

% stop condition
if abs(D) < TOL
fprintf(1,'\nApproximate solution = %.10e\n',P0);
fprintf(1,'with F(P) = %.10e\n',F0);
fprintf(1,'Number of iterations = %d\n',I);
fprintf(1,'Tolerance = %.10e\n',TOL);
OK = 0;
else
I = I+1;
end

end
