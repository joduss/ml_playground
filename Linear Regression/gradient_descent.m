sample_count = 500;

X = 0.5 + 0.25 * randn(sample_count,2);

w = abs([ rand(1); rand(1) ])

Y = X * w;
Y = Y + 0.8*randn(sample_count, 1);

%plot(X(:,2), Y, '.');
%pause();

%To find
w_p = [1;-2]; 

% error function: e = x'* w - y
 
[w0 w1] = meshgrid(-2:0.01:2);
 
cost = arrayfun(@(w0, w1) mse(Y, X, [w0; w1]), w0, w1);

close all;
contourf(w0,w1,log10(cost));
shading interp;
colormap summer;
set(gcf,'Position',[100 100 1000 1000]);

hold on;

w_all = [];

stepsize = 0.025;

% Gradient Descent
% -----------------
for i = 0:500
    
    %gradient descent mse
    gradient = mse_gradient(Y, X, w_p);
    w_p = w_p - stepsize * gradient;

    w_all = [w_all w_p];
    
    pause(0.01);
    
    plot(w_all(1,:), w_all(2,:), 'yellow');    
end


%Least Square: Find in one computation
% -----------------
%w_p = inv(X' * X) * X' * Y;



% Stochastic Gradient Descent
% -----------------
w_all = [];
w_p = [1; -2];

for i = 0:1
    for j = 1:length(Y)
        
        
        %gradient descent mse
        gradient = mse_gradient(Y(j), X(j,:), w_p);
        w_p = w_p - stepsize * gradient;
        
        w_all = [w_all w_p];
        pause(0.0001);
        
        plot(w_all(1,:), w_all(2,:), 'red');
    end

    permutations = randperm(sample_count);
    X = X(permutations, :);
    Y = Y(permutations, :);
    
end


% Mini-Batch Gradient Descent
% -----------------

BATCH_SIZE = 10;

w_all = [];
w_p = [1; -2];
w_all_step = [w_p]

for i = 0:10
    
    permutations = randperm(sample_count);
    X = X(permutations, :);
    Y = Y(permutations, :);

    for j = 0:(length(Y) / BATCH_SIZE - 1)
        
        lower = 1 + j * BATCH_SIZE;
        higher = (j+1)* BATCH_SIZE;
        
        %gradient descent mse
        gradient = mse_gradient(Y(lower:higher), X(lower:higher,:), w_p);
        w_p = w_p - stepsize * gradient;
        
        w_all = [w_all w_p];
        pause(0.0001);
        
        plot(w_all(1,:), w_all(2,:), 'blue');
    end
    w_all_step = [w_all_step w_p];
    plot(w_all_step(1,:), w_all_step(2,:), 'green');
end
