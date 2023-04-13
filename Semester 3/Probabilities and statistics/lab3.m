clear 
clc
close all

% Nickel powders are used in coatings used to shield electronic equipment.
% A random sample is selected and the sizes of nickel particles in each
% coating are recorded (they are assumed to be approximately normally
% distributed):
x = [3.26 1.89 2.42 2.03 3.07 2.95 1.39 3.06 2.46 3.35 1.56 1.79 1.76 3.82 2.42 2.96];
n = length(x);
alpha = 0.05;

% a). At the 5% significance level, on average, do these nickel particles
% seem to be smaller than 3?
% Null hypothesis: the mean is equal to 3.
% Alternative hypothesis: the mean is smaller than 3.
fprintf('a).\n')
m0 = 3;
[H, P, CI, stat] = ttest(x, m0, 'alpha',alpha, 'tail', 'left'); %we have a left-tailed test
% H is the rejection of the null hypothesis, P the P-value, CI the
% confidence interval, zstat the value of the test statistic
if H == 0
    fprintf('The null hypothesis is NOT rejected, the particles seem to be larger than 3.\n')
else
    fprintf('The null hypothesis is rejected, the particles seem to be smaller than 3.\n')
end

%quantile for distribution
q = tinv(alpha, n - 1);
fprintf('The rejection region is (%6.4f, %6.4f):\n', -inf, q)
fprintf('Thhe confidence interval is (%4.4f, %4.4f):\n', CI)
fprintf('The value of the test statistic is %6.4f:\n', stat.tstat)
fprintf('The P-value for the variances test is %6.4f:\n', P)

% b). Find a 99% confidence interval for the standard deviation of the size
% of nickel particles.
fprintf('b).\n')
confidence = 0.99;
alpha = 1 - confidence;

%we compute the standard deviation of the vector
standardDeviationX = std(x);

%we compute the average of the vector
averageX = mean(x);

% we need the standard deviation of x so we use the second case from the
% confidence interval file and compute using chi 2. This gives us the
% variance so we need to sqrt to convert to standard deviation

o1 = (n-1)*standardDeviationX*standardDeviationX/chi2inv(1-alpha/2, n-1);
o2 = (n-1)*standardDeviationX*standardDeviationX/chi2inv(alpha/2, n-1);

s1 = sqrt(o1);
s2 = sqrt(o2);
fprintf('The interval is (%f, %f)\n', s1, s2)




