function e = mse(Y, X, w)  
    Yp = X * w;
    e = (1 / size(Y,1)) * (Y - Yp)' * (Y - Yp);
end