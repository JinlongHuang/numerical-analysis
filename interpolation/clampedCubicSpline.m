% CLAMPED CUBIC SPLINE ALGORITHM 3.5
%
% To construct the cubic spline interpolant S for the function f,
% defined at the numbers x(0) < x(1) < ... < x(n), satisfying
% S'(x(0)) = f'(x(0)) and S'(x(n)) = f'(x(n)):

syms('OK', 'FLAG', 'N', 'I', 'X', 'A', 'AA', 'NAME', 'INP'); 
syms('FP0', 'FPN', 'M', 'H', 'XA', 'XL', 'XU', 'XZ', 'C', 'J'); 
syms('B', 'D', 'OUP','s','x');
TRUE = 1;
FALSE = 0;
fprintf(1,'This is Clamped Cubic Spline Interpolation.\n');
fprintf(1,'=================================================\n');

X = [0, 3, 5, 8, 13];
A = [0, 225, 383, 623, 993];
FP0 = 75;
FPN = 72;
N = 4;

% STEP 1
M = N - 1;
H = zeros(1,M+1);
for I = 0:M
    H(I+1) = X(I+2) - X(I+1);
end
% STEP 2
% use XA instead of alpha
XA = zeros(1,N+1);
XA(1) = 3.0 * (A(2) - A(1)) / H(1) - 3.0 * FP0;
XA(N+1) = 3.0 * FPN - 3.0 * (A(N+1) - A(N)) / H(N);
% STEP 3
for I = 1:M
    XA(I+1) = 3.0*(A(I+2)*H(I)-A(I+1)*(X(I+2)-X(I))+A(I)*H(I+1))/(H(I+1)*H(I));
end
% STEP 4
% STEPS 4, 5, 6 and part of 7 solve the tridiagonal system using Algorithm 6.7
% use XL, XU, XZ in place of L, MU, Z resp.
XL = zeros(1,N+1);
XU = zeros(1,N+1);
XZ = zeros(1,N+1);
XL(1) = 2.0 * H(1);
XU(1) = 0.5;
XZ(1) = XA(1) / XL(1);
% STEP 5
for I = 1:M
    XL(I+1) = 2.0 * (X(I+2) - X(I)) - H(I) * XU(I);
    XU(I+1) = H(I+1) / XL(I+1);
    XZ(I+1) = (XA(I+1) - H(I) * XZ(I)) / XL(I+1);
end
% STEP 6
XL(N+1) = H(N) * (2.0 - XU(N));
XZ(N+1) = (XA(N+1) - H(N) * XZ(N)) / XL(N+1);
C = zeros(1,N+1);
B = zeros(1,N+1);
D = zeros(1,N+1);
C(N+1) = XZ(N+1);
% STEP 7
for I = 1:N
    J = N - I;
    C(J+1) = XZ(J+1) - XU(J+1) * C(J+2);
    B(J+1) = (A(J+2)-A(J+1))/H(J+1)-H(J+1)*(C(J+2)+2.0*C(J+1))/3.0;
    D(J+1) = (C(J+2) - C(J+1)) / (3.0 * H(J+1));
end 

fprintf(1, '\n\nThe coefficients of the spline on the subintervals '); 
fprintf(1, 'are:\n');
fprintf(1, 'for I = 0, 1, 2, 3\n');
fprintf(1, '     A(I)          B(I)           C(I)         D(I)\n');
for I = 0:M
    fprintf(1,'%13.8f %13.8f %13.8f %13.8f\n',A(I+1),B(I+1),C(I+1),D(I+1));
end

FT10 = A(4) + B(4)*2 + C(4)*4 + D(4)*8;
fprintf(1,'\nThe distance at t=10s is %13.8f\n', FT10);

FP2 = @(x) B(2)+2*C(2)*(x-3)+3*D(2)*(x-3)^2;
FP3 = @(x) B(3)+2*C(3)*(x-5)+3*D(3)*(x-5)^2;

flag = 0;
maxSpeed = 0;
k = 3.0;
for k = 3.0:0.01:5.0
    if FP2(k) >= 80.6667
        fprintf(1,'\nTime when speed is beyond 55 mi/h t = %13.8f\n', k);
        maxSpeed = max(FP3(k),maxSpeed);
        flag = 1;
        break;
    end
end

if flag == 0
    k = 5.0;
    for k = 5.0:0.01:8.0
        if FP3(k) >= 80.6667
            fprintf(1,'\nTime when speed is beyond 55 mi/h t = %13.8f\n', k);
            maxSpeed = max(FP3(k),maxSpeed);
            fprintf(1,'\nThe max speed is %13.8f\n',maxSpeed);
            break;
        end
    end
end


 
