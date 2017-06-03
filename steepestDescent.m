% Steepest descent method to approximate the minima of cos(x1+x2)+sin(x1)
% +cos(x2) within 0.005.

iteMax = 30;
tol = 0.005;

x = zeros(2,iteMax);
z = zeros(2,iteMax);

k = 1;
while k <= iteMax
    g = @(x1,x2)   cos(x1+x2)+sin(x1)+cos(x2);
    gx1 = @(x1, x2) -sin(x1+x2)+cos(x1);
    gx2 = @(x1, x2) -sin(x1+x2)-sin(x2);

    g1 = g(x(1,k), x(2,k));
    z(1,k) = gx1(x(1,k),x(2,k));
    z(2,k) = gx2(x(1,k),x(2,k));
    z0 = sqrt(z(1,k)^2+z(2,k)^2);
    if z0 == 0
        fprintf(1, 'Zero gradient\n');
        fprintf(1,'%4.4f %4.4f %4.4f\n', x(1,k), x(2,k), g1);
        return;
    end    
    z(1,k) = z(1,k)/z0;
    z(2,k) = z(2,k)/z0;
    a1 = 0;
    a3 = 1;
    g3 = g(x(1,k)-a3*z(1,k), x(2,k)-a3*z(2,k));
    while g3 >= g1
        a3 = a3/2;
        g3 = g(x(1,k)-a3*z(1,k), x(2,k)-a3*z(2,k));
        if a3 < tol/2
            fprintf(1,'Not likely improvement\n');
            fprintf(1,'%4.4f %4.4f %4.4f\n', x(1,k), x(2,k), g1);
            return;
        end
    end
    a2 = a3/2;
    g2 = g(x(1,k)-a2*z(1,k), x(2,k)-a2*z(2,k));
    h1 = (g2-g1)/a2;
    h2 = (g3-g2)/(a3-a2);
    h3 = (h2-h1)/a3;
    % Newton's forward divided-difference formula is used to find the 
    % quadratic function P(a)
    a0 = 0.5*(a2-h1/h3);
    g0 = g(x(1,k)-a0*z(1,k), x(2,k)-a0*z(2,k));
    if g0 <= g3
        a = a0;
    else
        a = a3;
    end
    g = g(x(1,k)-a*z(1,k), x(2,k)-a*z(2,k));
    x(1,k+1) = x(1,k) - a*z(1,k);
    x(2,k+1) = x(2,k) - a*z(2,k);
    if abs(g-g1) <= tol
        fprintf(1,'Number of iteration is %d\n', k);
        fprintf(1,'x1 is %4.4f\n', x(1,k+1));
        fprintf(1,'x1 is %4.4f\n', x(2,k+1));
        fprintf(1,'g is %4.4f\n', g);
        return;
    end
    k = k + 1;
end


