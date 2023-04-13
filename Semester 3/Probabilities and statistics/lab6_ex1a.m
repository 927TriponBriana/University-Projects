alpha = input('alpha=');
x = [7 7 4 5 9 9 4 12 8 1 8 7 3 13 2 1 17 7 12 5 6 2 1 13 14 10 2 4 9 11 3 5 12 6 10 7];

m0 = input('m0= ');
% H0 : mu = m0
% H1 : mu < m0 - left-tailed test
sigma = 5;
[H, P, CI, ZVAL] = ztest(x, m0, sigma, 'alpha', alpha, 'tail', 'left');
RR = [-inf, norminv(alpha)]; % rejection region for left-tailed test
fprintf('The confidence interval is (%4.4f,%4.4f)\n', CI)
fprintf('The rejection region is (%4.4f, %4.4f)\n', RR)
fprintf('The P-value of the test is %4.4f\n', P)
if H == 1 % result of the test, h = 0, if H0 is not rejected, h = 1, if H0 is rejected
    fprintf('\nThe null hypothesis is rejected.\n') 
    fprintf('The data suggests that the standard is not met.\n')
    % there exists a computer whose average is < 9
else
    fprintf('\nThe null hypothesis is not rejected.\n')
    fprintf('The data suggests that the standard is met.\n')
end

