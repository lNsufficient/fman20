function [classification_data] = class_train(X, Y)
%CLASS_TRAIN Summary of this function goes here
%   Detailed explanation goes here
C = 2;

K = kernel(X);

%Setting up quadprog problem to solve with 
%x = quadprog(H,f,A,b,Aeq,beq,lb,ub)
A = zeros(size(alpha'));
A = [];
b = 1;
b = [];
Aeq = y';
beq = 0;
lb = zeros(size(alpha));
ub = C*ones(size(alpha));
f = ones(size(alpha));
H = (y*y').*K;

x = quadprog(H,f,A,b,Aeq,beq,lb,ub);
end

