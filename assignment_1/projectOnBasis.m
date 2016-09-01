function [up, r] = projectOnBasis(u, e1, e2, e3, e4)
%PROJECTONBASIS Projects an image u onto a basis (e1, e2, e3, e4), result
%is up and the error norm r = |u-up|.
TOL = 1e-9;
dot = @(x,y) x(:)'*y(:);
dotfast = @(x,y) sum(sum(conj(x).*y));
nom = @(u) sqrt(dot(u,u));

x = [dot(u, e1), dot(u,e2), dot(u,e3), dot(u,e4)];
xfast = [dotfast(u, e1), dotfast(u,e2), dotfast(u,e3), dotfast(u,e4)];

if sum(abs(x-xfast)./nom(x) > TOL)
    disp('something is wrong with at least one dot product');
end

up = x(1)*e1 + x(2)*e2 + x(3)*e3 + x(4)*e4;
r = nom(u - up);
end

