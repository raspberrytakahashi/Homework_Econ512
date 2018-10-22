% Motoaki Takahashi
% HW4 for Econ 512 Empirical Method

clear
%% Question 1

% I draw 1000 points in the unit square from Halton sequence.
n = 100^2;
h = haltonseq(n, 2);
hsq = h.^2;
hsq = sum(hsq, 2);
hsq = hsq(hsq<=1);
pi1=4*length(hsq)/n
clear h hsq

%% Question 2
% weights are 1/100^2 where 100^2 is the # of draws (points)
x = transpose(0.01:0.01:1); % 100 by 1 vector running from 0.01 to 1
y = transpose(0.01:0.01:1); % 100 by 1 vector running from 0.01 to 1
grid =[kron(x, ones(100,1)), kron(ones(100,1), y)];
grid = grid.^2;
grid = sum(grid, 2);
grid = grid(grid<=1);
pi2 = 4*length(grid)/(100^2)
clear grid

%% Question 3

h = haltonseq(n, 1);
h = sqrt(1-h.^2);
pi3 = 4*sum(h)/n

%% Question 4

grid = 0.0001:0.0001:1; % 10000 vector
grid = sqrt(1-grid.^2);
pi4 = 4*sum(grid)/length(grid)
clear grid

%% Question 5

% We have two methods: (1) two-dimensional random draws (2) one-dimensional
% implicit function

% (1) two dimendional

% Here I use the built-in function haltonset to get a Halton sequence.
% https://www.mathworks.com/help/stats/generating-quasi-random-numbers.html
% Following the above web page, get a sequnce that skips the first 1000 values of the Halton sequence and then retains every 101st point
p = haltonset(2,'Skip',1e3,'Leap',1e2);
% Apply reverse-radix scrambling
p = scramble(p,'RR2');

% 200 simulations of 1000 draws
% sim_pi.m gets the simulated value for pi from the draws (or grids)
k= 1000; % the # of draws
sim_pi_1000 = ones(200,1); % we place simulated pi's here
for i = 1:200
    x = p(1+k*(i-1):k+k*(i-1),:);
    sim_pi_1000(i,1) = sim_pi(x);
end
mean(sim_pi_1000)
mse_1000 = mean((sim_pi_1000-pi*ones(200,1)).^2)

% 10000 draws
k= 10000;
sim_pi_10000 = ones(200,1); % we place simulated pi's here
for i = 1:200
    x = p(1+k*(i-1):k+k*(i-1),:);
    sim_pi_10000(i,1) = sim_pi(x);
end
mean(sim_pi_10000)
mse_10000 = mean((sim_pi_10000-pi*ones(200,1)).^2)

% 100000 draws
k = 100000;
sim_pi_100000 = ones(200,1); % we place simulated pi's here
for i = 1:200
    x = p(1+k*(i-1):k+k*(i-1),:);
    sim_pi_100000(i,1) = sim_pi(x);
end
mean(sim_pi_100000)
mse_100000 = mean((sim_pi_100000-pi*ones(200,1)).^2)

% Newton-Coates for the two-dimensional case
% 1000 grids
% somewhat arbitrarily, I get 20 by 50 grids
x = (0.05:0.05:1).'; % 20-vector
y = (0.02:0.02:1).'; % 50-vector
grid =[kron(x, ones(50,1)), kron(ones(20,1), y)];
pi_nc_1000 = sim_pi(grid)
se_nc_1000 = (pi_nc_1000-pi)^2

%clear grid x y p

% 10000 grids
x = (0.01:0.01:1).'; % 100-vector
y = (0.01:0.01:1).'; % 100-vector
grid =[kron(x, ones(100,1)), kron(ones(100,1), y)];
pi_nc_10000 = sim_pi(grid)
se_nc_10000 = (pi_nc_10000-pi)^2

% 100,000 grids
x = (0.003:0.005:0.998).'; % 200-vector
y = (0.001:0.002:0.999).'; % 500-vector
grid =[kron(x, ones(500,1)), kron(ones(200,1), y)];
pi_nc_100000 = sim_pi(grid)
se_nc_100000 = (pi_nc_100000-pi)^2

% (2) one-dimensional, implicit function
p = haltonset(1,'Skip',1e3,'Leap',1e2);
p = scramble(p,'RR2');

% First, a quasi-MC
% 200 simulations of 1000 draws







