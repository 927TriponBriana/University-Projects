clear 
clc
close all

x = [3.26, 1.89, 2.42, 2.03, 3.07, 2.95, 1.39, 3.06, 2.46, 3.35, 1.56, 1.79, 1.76, 3.82, 2.42, 2.96];



%b). At the 1% significance level, on average, do these nickel particles
%seem to be smaller than 3?

fprintf('b).\n')
% Null hypothesis: the mean is equal to 3.
% Alternative hypothesis: the mean is smaller than 3.
alpha = 0.01; %significance level
m0 = 3;
[H, P, CI, stat] = ttest(x, m0, 'alpha',alpha, 'tail', 'left'); %we have a left-tailed test
% H is the rejection of the null hypothesis, P the P-value, CI the
% confidence interval, stat the value of the test statistic
if H == 0 % result of the test, H = 0, if H0 is not rejected, H = 1, if H0 is rejected
    fprintf('The null hypothesis is NOT rejected, the particles seem to be larger than 3.\n')
else
    fprintf('The null hypothesis is rejected, the particles seem to be smaller than 3.\n')
end

RR = [-inf, norminv(alpha)]; % rejection region for left-tailed test
%q = tinv(alpha, n - 1); % quantile for distribution
%fprintf('The rejection region is (%6.4f, %6.4f):\n', -inf, q)
fprintf('The rejection region is (%6.4f, %6.4f).\n', RR) 
fprintf('Thhe confidence interval is (%4.4f, %4.4f).\n', CI)
fprintf('The value of the test statistic is %6.4f.\n', stat.tstat)
fprintf('The P-value for the variances test is %6.4f.\n', P)

%a). Find a 95% confidence interval for the average size of the nickel
%particles.
fprintf('a).\n')
n = length(x);
vx = var(x); % we compute the variance of the vector
mx = mean(x); %we compute the average of the vector
confidence = 0.95;
alpha = 1 - confidence;

o1 = (n-1)*mx*mx/chi2inv(1-alpha/2, n-1);
o2 = (n-1)*mx*mx/chi2inv(alpha/2, n-1);

s1 = sqrt(o1);
s2 = sqrt(o2);

fprintf('The interval is (%f, %f)\n', s1, s2)