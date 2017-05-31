function y = compositeSimpson( x )
%SIMPSON for 1/sqrt(2*pi)*e^(-t^2/2) from 0 to x.

N = 10;
h = x/N;

y0 = 1;
y3 = exp(-x^2/2);
y1 = 0;
y2 = 0;

for i = 2:2:N-2
    y1 = y1 + exp(-(i*h)^2/2);
end    

for i = 1:2:N-1
    y2 = y2 + exp(-(i*h)^2/2);
end    

y = h/3*(y0+2*y1+4*y2+y3)*1/sqrt(2*pi) -0.45;

end

