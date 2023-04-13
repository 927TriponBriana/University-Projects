clear
clc
close all

% A food store owner receives 1-litter bottles from two suppliers.
% After some complaints from customers, he wants to check the accurancy of
% the weigths of 1-litter water bottles. He find the following weigths (the 
% two populations are approximately normally distributed):

% a). At 5% significance level, do the population variances seem to differ?
% Null hypothesis: the population variances are equal.
% Alternative hypothesis: the population variances differ.

% b). At the same significance level, on average, does Supplier A seem to
% be more reliable?

x1 = [1021, 980, 1017, 988, 1005, 998, 1014, 985, 995, 1004, 1030, 1015, 995, 1023];
x2 = [1070, 970, 993, 1013, 1006, 1002, 1014, 997, 1002, 1010, 975];
n1 = length(x1);
n2 = length(x2);
alpha = 0.05;

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
    fprintf('H0 is NOT rejected. Suplier A is not more reliable.\n')
else
    fprintf('H0 is rejected. Suplier A is more reliable.\n')
end

fprintf('P-value of the test statistic is %.4f.\n', p)
fprintf('Observed value of the test statistic is %1.4f.\n', stats.tstat)

q1 = tinv(1-alpha, stats.df);

fprintf('Rejection region R is (%3.4f, +inf).\n', q1)

