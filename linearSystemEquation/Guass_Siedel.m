% 7.3-11
% Guass_Siedel iteration to solve a 3 x 3 linear system equation
% A = [1,0,-1;-1/2,1,-1/4;1,-1/2,1]
% b = [0.2;-1.425;2]
% The accurate solution is [0.9;-0.8;0.7]

Tg = [0,0,1;0,0,3/4;0,0,-5/8];

invD_L = [1,0,0;1/2,1,0;-3/4,1/2,1];

Cg = invD_L*[0.2;-1.425;2];

xt = zeros(3,300);

xt(:,1) = [0;0;0];

xFin = [0.9;-0.8;0.7];

for i = 2:300
    xt(:,i) = Tg*xt(:,i-1)+Cg;
    if max(abs(xt(:,i)-xFin))/max(xFin) <= 10^(-2)
        fprintf(1, 'The result is : %4.3f\n',xt(:,i));
        fprintf(1,'The number of iteration is : %d\n', i-1)
        break;
    end
end

fprintf(1,'\n');

% 7.3-11
% Guass_Siedel iteration to solve a 3 x 3 linear system equation
% A = [1,0,-2;-1/2,1,-1/4;1,-1/2,1]
% b = [0.2;-1.425;2]

Tg = [0,0,2;0,0,5/4;0,0,-11/8];

invD_L = [1,0,0;1/2,1,0;-3/4,1/2,1];

Cg = invD_L*[0.2;-1.425;2];

xt = zeros(3,300);

xt(:,1) = [0;0;0];

for i = 2:300
    xt(:,i) = Tg*xt(:,i-1)+Cg;
    if max(abs(xt(:,i)-xt(:,i-1)))/max(abs(xt(:,i))) <= 10^(-2)
        fprintf(1, 'The result is : %4.3f \n',xt(:,i));
        fprintf(1,'The number of iteration is : %d\n', i-1);
        break;
    end
end
