function [alpha, b, X] = class_train(X, Y)
%CLASS_TRAIN Summary of this function goes here
%   Detailed explanation goes here
C = 2;

K = kernel(X, X);

%Setting up quadprog problem to solve with 
%x = quadprog(H,f,A,b,Aeq,beq,lb,ub)

%A = zeros(size(alpha'));
A = [];
%b = 1;
b = [];
Aeq = Y;
beq = 0;
lb = zeros(size(Y'));
ub = C*ones(size(Y'));
f = ones(size(Y'));
H = (Y'*Y).*K; %outer prod, men Y är en radvektor

alpha = quadprog(H,f,A,b,Aeq,beq,lb,ub);
b = mean((alpha'*K - Y));
end

