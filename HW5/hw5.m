% Motoaki Takahashi
% HW5 for Econ 512 Empirical Method

clear
delete HW5log.txt
diary('HW5log.txt')
diary on
load('hw5.mat')
addpath('../CEtools/');
X = data.X;
Y = data.Y;
Z = data.Z;
N = 100;
T = 20;

%% Q1
disp('Question 1')
par = [0, 0.1, 1];
-withoutu(X, Y, Z, par, 20, 1, N, T)

%% Q2
disp('Question 2')
-withoutu(X, Y, Z, par, 100, 2, N, T)

%% Q3
disp('Question 3')
disp('Gaussian Quadrature')
% restrict the arguments to only par
withoutu_min = @(par) withoutu(X, Y, Z, par, 20, 1, N, T);
par = ones(3,1); % When I started with pi*ones(1,3), I didn't get the result.

% minimize the log-likelihood with the restriction that the variance is
% positive

% restriction in fmincon
A = [0, 0, -1];
b = 0;

[x, fval] = fmincon(withoutu_min, par, A, b);
% take a look at answer key to see how can you use the same function with
% imposed equality constraints here in in question 4
disp('The minimizer is')
disp('gamma beta0 sigmab')
disp(x')
disp('The value of the negative log-likelihood is')
disp(fval)

disp('Monte Carlo')
% restrict the arguments to only par
withoutu_min = @(par) withoutu(X, Y, Z, par, 100, 2, N, T);
par = ones(3,1);
[x, fval] = fmincon(withoutu_min, par, A, b);
disp('The minimizer is')
disp('gamma beta0 sigmab')
disp(x')
disp('The value of the negative log-likelihood is')
disp(fval)


%% Q4

X = data.X;
Y = data.Y;
Z = data.Z;
N = 100;
T = 20;


disp('Question 4')
% restrict the arguments to only par
withu_min = @(par) withu(X, Y, Z, par, 100, N, T);
par = [ 1;1;1;1;1;0.3 ]; %cholesky decomposition needs a pd matrix

% constraint
A = [ 0, 0, -1, 0, 0, 0;
      0, 0, 0, 0, -1, 0;
      0, 0, 0, 0, 0, 1;
      0, 0, 0, 0, 0, -1];
b = [ 0; 0; 1; 1];
[x, fval] = fmincon(withu_min, par, A, b);
disp('The minimizer is')
disp('   gamma      beta0    sigmab    u0    sigmau   rho')
disp(x')
disp('The value of the negative log-likelihood is')
disp(fval)

diary off
