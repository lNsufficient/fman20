function [up, upn, x, r] = projectOnBasis(u, e)
%PROJECTONBASIS Projects an image u onto a basis spanned by e.
%   up - orthogonal projection
%   e - basis, i:th basis vector is found in e(:,:,i).
%   r = |u-up|.
%   upn = |up|
TOL = 1e-9;
dot = @(x,y) x(:)'*y(:);
%dotfast = @(x,y) sum(sum(conj(x).*y));
nom = @(u) sqrt(dot(u,u));

[~, ~, o] = size(e);

x = zeros(o,1);

for i = 1:o
    x(i) = dot(u, e(:,:,i));
end

%xfast = [dotfast(u, e1), dotfast(u,e2), dotfast(u,e3), dotfast(u,e4)];

% if sum(abs(x-xfast)./nom(x) > TOL)
%     disp('something is wrong with at least one dot product');
% end

up = zeros(size(u));
for i = 1:o
    up = up + x(i)*e(:,:,i);
end

r = nom(u - up);
upn2 = nom(up);
upn = sqrt(sum(x.^2)); %This requires e to be orthonormal basis
if abs(upn - upn2) > 1e-11
    disp('something wrong with norms')
end
end