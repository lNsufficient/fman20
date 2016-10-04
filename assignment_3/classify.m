function Y = classify(X, alpha, b, Xclass, G)
%CLASSIFY Summary of this function goes here
%   Detailed explanation goes here

K = kernel(Xclass, X);
Gv = alpha'*K + b;
Gv = G(X);
Y = 2*(Gv > 0)-1;

end

