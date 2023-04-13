%a. and b.
n = 3;
p = 0.5;
k = 0 : 1 : n;
y = binopdf(k, n, p);
%subplot(4,1,3)
plot(k,y)
hold on
w = 0 : 0.001 : n;
z = binocdf(w, n, p);
%subplot(4,1,4)
plot(w,z)
hold off

%c.
p1 = binopdf(0,3,1/2);
p2 = 1-binopdf(1,3,1/2);
fprintf('P(X = 0) = %1.6f\n', p1)
fprintf('P(X != 1) = %1.6f\n)', p2)

%d.
p3 = binocdf(2, 3, 1/2);
p4 = binocdf(1, 3, 1/2);
fprintf('P(X <= 2) = %1.6f\n', p3)
fprintf('P(X < 2) = %1.6f\n)', p4)

%e.
p5 =1 - binocdf(0, 3, 1/2);
p6 =1 - binocdf(1, 3, 1/2);
fprintf('P(X => 1) = %1.6f\n', p5)
fprintf('P(X > 1) = %1.6f\n)', p6)
