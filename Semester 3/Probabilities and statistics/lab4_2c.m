clear ALL
p=input('Probability of success= ');
X=0;
while(rand >= p)
    X=X+1;
end
clear X;
N=input('Number of simulations= ');
for i=1:N
    X(i)=0;
    while(rand>=p)
        X(i)=X(i)+1;
    end
end

U_X = unique(X);
n_X=hist(X, length(U_X));
relative_freq=n_X/N;
k=0:50;
pk=geopdf(k,p);
clf
plot(k,pk,'bo',U_X,relative_freq,'rx', 'MarkerSize', 10)
legend('Geo distr','Simulation')
