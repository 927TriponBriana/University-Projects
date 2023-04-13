clear ALL
n = input('Rank of success= ');
p=input('Probability success= ');
for j = 1:n
    Y(j)=0;
    while(rand >= p)
        Y(j)=Y(j)+1;
    end
end
X=sum(Y);
clear X;
N=input('Number of simulations= ');
for i=1:N
    for j=1:n
        Y(j)=0;
        while(rand >= p)
            Y(j)=Y(j)+1;
        end
    end
    X(i)=sum(Y);
end

U_X = unique(X);
n_X = hist(X,length(U_X));
relative_freq = n_X/N;

k = 0:50;
pk = nbinpdf(k,n,p);
clf
plot(k,pk,'bo',U_X,relative_freq,'rx','Markersize',10)
legend('Nbin distr','Simulation')
