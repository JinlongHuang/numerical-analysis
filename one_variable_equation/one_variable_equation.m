% Using bisection, Secant, Muller's, Newton's and false position to ?nd a 
% solution in [0.1, 1] accurate to within 10^(?4) for 
% 600*x^4?550*x^3+200*x^2?20*x?1=0.
% 
% ©2017 qWalker All Right Reserved.
% -------------------------------------------------------------------------

a = 0.1;
b = 1;
I = 1;
NO = 30;
TOL = 10^(-4);

file1 = fopen('2.6_9.txt','w');

% Bisection
fprintf(file1, 'Bisection Method\n');
fprintf(file1, '  I   P                 F(P)\n');
c = (a + b)/2;
while (b-a)>=TOL && I <= 30
    fprintf(file1, '%3d   %14.8e   %14.7e\n',I,c,F(c));
    if F(a)*F(c)>=0
        a = c;
    else
        b = c;
    end
    c = (a + b)/2;
    I = I + 1;
end

% Secant
fprintf(file1, '\n\nSecant Method\n');
fprintf(file1, '  I   P                 F(P)\n');
P0 = 0.1;
P1 = 1;
I = 1;
flag = 1;
while flag == 1 && I <= NO
    D = F(P1)*(P1-P0);
    D1 = F(P1)-F(P0);
    D2 = D/D1;
    P0 = P1 - D2;
    tem = P0;
    P0 = P1;
    P1 = tem;
    fprintf(file1,'%3d   %14.8e   %14.7e\n',I,P1,F(P1));
    if abs(D2) <= TOL
        flag = 0;
    else
        I = I + 1;
    end
end

% Muller's 
fprintf(file1, '\n\nMuller''s Method\n');
fprintf(file1, '  I   P                 F(P)\n');
P0 = 0.2;
P1 = 0.3;
P2 = 0.5;
I = 1;
h1 = P1-P0;
h2 = P2-P1;
d1 = (F(P1)-F(P0))/h1;
d2 = (F(P2)-F(P1))/h2;
d = (d2-d1)/(h2+h1);
while I <= NO
    b = d2 + h2*d;
    DD = sqrt(b^2-4*F(P2)*d);
    if abs(b-DD)<abs(b+DD)
        E = b + DD;
    else 
        E = b - DD;
    end
    h = -2*F(P2)/E;
    P = P2 + h;
    if abs(h)<=TOL
        break
    end
    P0 = P1;
    P1 = P2;
    P2 = P;
    h1 = P1 - P0;
    h2 = P2 - P1;
    d1 = (F(P1)-F(P0))/h1;
    d2 = (F(P2)-F(P1))/h2;
    d = (d2-d1)/(h2+h1);
    fprintf(file1,'%3d   %14.8e   %14.7e\n',I,P,F(P));
    I = I + 1;
end

% Newton's
fprintf(file1, '\n\nNewton''s Method\n');
fprintf(file1, '  I   P                 F(P)\n');
P0 = 0.5;
I = 1;
while I <= NO
    D = F(P0)/FP(P0);
    P0 = P0 - D;
    fprintf(file1,'%3d   %14.8e   %14.7e\n',I,P0,F(P0));
    if abs(D) <= TOL
        break
    else
        I = I + 1;
    end    
end

% False position
fprintf(file1, '\n\nFalse Position Method\n');
fprintf(file1, '  I   P                 F(P)\n');
P0 = 0.1;
P1 = 0.38;
I = 1;
while I <= NO
    D = F(P1)*(P1-P0);
    D1 = F(P1)-F(P0);
    D2 = D/D1;
    P2 = P1 - D2;
    if F(P2)*F(P1)>=0
        P1 = P2;
    else
        P0 = P1;
        P1 = P2;
    end
    fprintf(file1,'%3d   %14.8e   %14.7e\n',I,P1,F(P1));
    if abs(D2) <= TOL
        break
    else
        I = I + 1;
    end
end

fclose(file1);

