function d = dist(x, X)
%DIST calculates d(x, X) för alla kolummner i X.
%   x - kolonnvektor
%   X - matris vars kolonnvektorer är motsvarande till x. 
n = size(X,2);
x_big = x*ones(1,n);
diff = X - x_big;
d = sqrt(sum(diff.^2));

end

