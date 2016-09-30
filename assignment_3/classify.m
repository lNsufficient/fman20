function Y = classify(X, alpha, b, Xclass)
%CLASSIFY Summary of this function goes here
%   Detailed explanation goes here

K = kernel(Xclass, X);
G = alpha'*K + b;
Y = 2*(G > 0)-1;

end

