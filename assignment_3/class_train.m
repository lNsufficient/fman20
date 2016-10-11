function [g] = class_train(X, Y)
%class_train: Class training, linear SVM. 

%Setting up quadprog problem to solve with 
%x = quadprog(H,f,A,b)

Ny = length(Y);
Nx = size(X,1);

H = eye(Nx+1);
H(end, end) = 0;

f = zeros(Nx+1,1);

A = -[diag(Y)*X' Y'];
b = -ones(Ny,1);

wb = quadprog(H,f,A,b);
b = wb(end);
w = wb(1:end-1);
g = @(x) w'*x + b;
%test = (w'*X + b).*Y - 1;
end

