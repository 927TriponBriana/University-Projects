option= input('option(normal/student/n/fischer): ', 's');

switch option
    case 'normal'
        fprintf('normal case\n');
        miu = input('introduce miu: ');
        sigma = input('introduce sigma: ');
        
        %a. P(X<=0), P(X>=0)
        pa1 = normcdf(0, miu, sigma);
        pa2 = 1 - pa1;
        fprintf('Probability a) %f\n', pa1);
        fprintf('Probability a) %f\n', pa2);
        
        %b. P(−1 <= X <= 1) andP(X <= −1 orX >= 1);
        pb1 = normcdf(1, miu, sigma) - normcdf(-1, miu, sigma);
        pb2 = 1 - pb1;
        fprintf('Probability b) %f\n', pb1);
        fprintf('Probability b) %f\n', pb2);

        %c.
        alpha = input('alpha = ');
        answc = norminv(alpha, miu, sigma);
        fprintf('Probability c) %f\n', answc);

        %d. 
        beta = input('beta = ');
        answd = norminv(1-beta, miu, sigma);
        fprintf('Probability d) %f\n', answd);
        
    case 'student'
        fprintf('student case\n');
    case 'fischer'
        fprintf('fischer case\n');
    otherwise
        fprintf('incorrect input\n');
end