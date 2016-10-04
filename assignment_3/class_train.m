function [alpha, b, X] = class_train(X, Y)
%CLASS_TRAIN Summary of this function goes here
%   Detailed explanation goes here
C = 30;
TOL = 1e-6;

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
H = -(Y'*Y).*K; %outer prod, men Y �r en radvektor

fval = @(alpha) f'*alpha +1/2*alpha'*H*alpha;
for i = 1:1
    alpha = quadprog(-H,-f,A,b,Aeq,beq,lb,ub);
    maxAlpha = max(alpha)
    minAlpha = min(alpha)
    newVal = fval(alpha);
    C = min(max(alpha),C);
    ub = C*ones(size(Y'));
end
%MODEL = fitcsvm(X, Y, 'Para)
SVindex = find(abs(alpha)>TOL);
b = mean((alpha(SVindex)'*K(SVindex,SVindex) - Y(SVindex)));
test = Y(SVindex).*(alpha(SVindex)'*K(SVindex,SVindex) + b)-1;
max(test)
end

