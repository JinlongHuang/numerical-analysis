function y = compositeTrap( x )
%Trapezoidal rule for 1/sqrt(2*pi)*e^(-t^2/2) from 0 to x.

N = 600;
h = x/N;

y0 = 1;
y2 = exp(-x^2/2);
y1 = 0;

for i = 1:N-1
    y1 = y1 + exp(-(i*h)^2/2);
end    

y = h/2*(y0+2*y1+y2)*1/sqrt(2*pi) -0.45;

end

