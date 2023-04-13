clear
clc
close all

% To reach the maximum efficiency in performin an assembling operation in a
% manufacturing plant, new employees are required to take a 1-month
% training course. A new methodwas suggested, and the manager wants to
% compare the new method with the standard one, by looking at the lenghts
% of time required for employees to assemble a certain device. They are
% given below (assumed approximately normally distributed):

%a).A t the 5% significance level, do the population variances seem to
%differ?
%Null hypothesis: variances are equal
%Alternative hypothesis: variances are different.

%b). Find a 95% confidence interval for the difference of the average
%assembling times.

x1 = [46, 37, 39, 48, 47, 44, 35, 31, 44, 37];
x2 = [35, 33, 31, 35, 34, 30, 27, 32, 31, 31];


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

fprintf('b.)\n')
vx1 = var(x1);
vx2 = var(x2);
mx1 = mean(x1);
mx2 = mean(x2);
if h == 1
    c = (vx1/n1)/(vx1/n1+vx2/n2);
    n = 1/(c^2/(n1-1)+(1-c)^2/(n2-1));
    t = icdf('t', 1-alpha/2, n);
    rad = sqrt(vx1/n1+vx2/n2);
    li = mx1-mx2-t*rad;
    ri = mx1-mx2+t*rad;
else
    n = n1+n2-2;
    t = icdf('t', 1-alpha/2, n);
    rad = sqrt(1/n1+1/n2);
    sp = sqrt(((n1-1)*vx1+(n2-1)*vx2)/n);
    li = mx1-mx2-t*sp*rad;
    ri = mx1-mx2+t*sp*rad;
end
fprintf('Confidence interval for the difference of the means is (%.4f, %.4f)\n', li, ri)


