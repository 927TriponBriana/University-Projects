p = input('p= ');
if p > 0.05
    fprintf('p should be less then 0.05');
end
n = input('n= ');
if n < 30
    fprintf('n should be greater then 30');
end
v = 0 : n;
plot(v, binopdf(v, n, p), 'm', v, poisspdf(v, n*p), 'b')