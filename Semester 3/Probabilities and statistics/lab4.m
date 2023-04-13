clear
clc
close all

% A study is cunducted to compare heat loss in glass pipes versus steel
% pipes of the same size. Various liquids at identical starting
% temperatures are run through segments of each type and the heat loss (in
% Celsius) is measured. These data result (normality of 2 populations is
% assumed):

%a). At the 5% significance level, do the population variances seem to
%differ?
%Null hypothesis: the varianves are equal
%Alternative hypothesis: the variances are different.

%b). At the same significance level, does it seem that on average, steel
%pipes lose more heat than glass pipes?
%Null hypothesis: the means are equal
%Alternative hypothesis: the means are not equal.

x1 = [4.6, 0.7, 4.2, 1.9, 4.8, 6.1, 4.7, 5.5, 5.4];
x2 = [2.5, 1.3, 2.0, 1.8, 2.7, 3.2, 3.0, 3.5, 3.4];
alpha = 0.05;
n1 = length(x1);
n2 = length(x2);

%taile values: -1 for left-tailed
%               0 for both
%               1 for right-tailed

%a.
%h0: sigma1  = sigma2
%h1: sigma1 =! sigma2 - two-tailed test
fprintf('a).\n')
tail = 0;
[h, p, ci, stats] = vartest2(x1, x2, alpha, tail); 
%p=P-value; ci=confidence level
if h == 0
    fprintf('H0 is NOT rejected, sigmas are equal.\n')
else
    fprintf('H0 is rejected, population variances differ.\n')
end

%q1 = finv(alpha/2, stats.df1, stats.df2);
%q2 = finv(1-alpha/2, stats.df2, stats.df1);
q1 = finv(alpha/2, n1-1, n2-1);
q2 = finv(1-alpha/2, n1-1, n2-1);

fprintf('Observed value is %1.4f\n', stats.fstat);
fprintf('P-value is %1.4f\n', p);
fprintf('Rejection region R is (-inf, %3.4f) U (%3.4f, inf)\n', q1, q2);

% b.
%h0: miu1  = miu2
%h1: miu1 > miu2 - rigth-tailed test
fprintf('b.)\n')
[h,p,ci,stats] = ttest2(x1, x2, alpha, 1, 'unequal');
% vartype = 'unequal', because in point a we got different values for
% population variances. If thei were equal, we would have used 'equal'.

if h == 0
    fprintf('H0 is NOT rejected. Steel pipes do NOT lose more heat than glass.\n')
else
    fprintf('H0 is rejected. Steel piped do lose more heat than glass.\n')
end

fprintf('P-value of the test statistic is %e.\n', p)
fprintf('Observed value of the test statistic is %1.4f.\n', stats.tstat)

q1 = tinv(1-alpha, stats.df);

fprintf('Rejection region R is (%3.4f, +inf).\n', q1)


