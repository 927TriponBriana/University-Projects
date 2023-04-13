clear ALL
n=input('Number of trials= ');
p=input('Probability of success = ');
U=rand(n,1);
%X=sum(U<p);
clear X;
N=input('Number of simulations= ');
for i=1:N
    U=rand(n,1);
    X(i)=sum(U<p);
end
U_X=unique(X);
n_X=hist(X, length(U_X));
relative_freq=n_X/N

xpdf=0:n;
ypdf=binopdf(xpdf,n,p);
clf;
plot(xpdf, ypdf, 'bo', U_X, relative_freq, 'rx', 'MarkerSize', 10);
legend('binopdf', 'simulation');
