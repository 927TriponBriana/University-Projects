clf
n = input('Nr. of trials n= ');
p = input('Probabiliti of success p= ');
x = 0 : n;
px = binopdf(x, n, p);
plot(x, px, 'r+')
hold on
xx = 0 : 0.01 : n;
fx = binocdf(xx, n, p);
plot(xx, fx, 'm')
legend('pdf', 'cdf')