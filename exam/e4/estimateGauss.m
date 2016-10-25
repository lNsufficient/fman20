function [muhat, sigmahat] = estimateGauss(X, plt)
%ESTIMATEGAUSS Returns the muhat and sigmahat for X, assuming that X is a
%gaussian distribtion with different means for each row, but the same
%variance for all data.
if (nargin < 2)
    plt = 0;
end

muhat = mean(X,2); %this is what mle will return anyway.
n = size(X,2);
muhat_big = muhat*ones(1,n);
X_0 = X-muhat_big;
phat = mle(X_0(:), 'distribution', 'normal');
sigmahat = phat(2);

if plt %just to check
    figure(1);
    h = hist(X_0(:));
    hist(X_0(:))
    hold on
    x = linspace(min(min(X_0)), max(max(X_0)));
    y = normpdf(x, 0, sigmahat);
    y = y*(max(h)/max(y));
    figure(1);
    plot(x,y);
end
end