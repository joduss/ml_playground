function gradient = mse_gradient(y,X, w)

error = y - X * w;
gradient = -1 / length(y) * X' * error;

end

