alpha = input('alpha=');

pr = [22.4 21.7 24.5 23.4 21.6 23.3 22.4 21.6 24.8 20.0];
rg = [17.7 14.8 19.6 19.6 12.1 14.8 15.4 12.6 14.0 12.2];

n1 = length(pr);
n2 = length(rg); %lengths of each array

m1 = mean(pr);
m2 = mean(rg); %means of each set

v1 = var(pr);
v2 = var(rg); %variances

f1 = finv(alpha/2, n1-1, n2-1);
f2 = finv(1-alpha/2, n1-1, n2-1); %quantiles for the rejection region of the two tailed test

[H, P, CI, ZVAL] = vartest2(pr, rg, "alpha", alpha);

fprintf('The rejection region for F is (%6.4f, %6.4f) U (%6.4f, %6.4f)\n', -inf, f1, f2, inf)
fprintf('The value of the test statistic F is %6.4f\n', ZVAL.fstat)
fprintf('The P-value for the variances test is %6.4f\n', P)

if H == 1
    fprintf('The null hypothesis is rejected.\n') 
    fprintf('Gas mileage IS higher with premium gasoline\n')
else
    fprintf('The null hypothesis is not rejected.\n')
    fprintf('Gas mileage IS NOT higher with premium gasoline\n')
end
