clear
clc
close all

% A study is conducted to compare the total printing time in seconds of two
% brands of laser printers on serious tasks. Data below are for the
% printing of the charts (normality of the 2 populations is assumed):

% a). At 5% significance level, do the population variances seem to differ?
% Null hypothesis: the population variances are equal.
% Alternative hypothesis: the population variances differ.

% b). At the same significance level, on average, does the Brand A printer
% seem to be faster?
% From A we fint if the variances of the populations are equal or not and
% we use that information here.
% In this case, the null hypothesis: the means are equal
% The alternative hypothesis: the mean of supplier A is grater than the one
% for B.
x1 = [29.8, 30.6, 29.0, 27.7, 29.9, 29.6, 30.5, 31.1, 30.2, 28.1, 29.4, 28.5];
x2 = [31.5, 30.2, 31.2, 29.0, 31.4, 31.1, 32.5, 33.0, 31.3, 30.9, 30.7, 29.9];

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
    fprintf('H0 is NOT rejected. Brand A seems to not be faster.\n')
else
    fprintf('H0 is rejected. Brand A seems to be faster.\n')
end

fprintf('P-value of the test statistic is %e.\n', p)
fprintf('Observed value of the test statistic is %1.4f.\n', stats.tstat)

q1 = tinv(1-alpha, stats.df);

fprintf('Rejection region R is (%3.4f, +inf).\n', q1)


