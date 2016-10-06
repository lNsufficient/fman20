function [alpha, b, X, G] = class_train_nonlinearSVM(X, Y)
%CLASS_TRAIN Summary of this function goes here
%   Detailed explanation goes here
C = 30;
TOL = 1e-6;

K = kernel(X, X);

%LÖSNING AV "FORMULATION", 
%http://www.ctr.maths.lu.se/media/FMAN20/2016/f11-classif-2015.pdf, 
%slide 21.

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

[alpha, fval] = quadprog(-H,-f,A,b,Aeq,beq,lb,ub);
maxAlpha = max(alpha)
minAlpha = min(alpha)
%C = min(max(alpha),C);
%ub = C*ones(size(Y'));


%LÖSNINGEN TILL "DISCRIMINANT FUNCTION"
SVindex = find(abs(alpha)>TOL);
SVindex = 1:numel(alpha); %Borde funka att använda alla index, eftersom att
%alpha = 0 på alla index som inte är index till SV.

%b beräknas enligt slide 6. Detta blir mer robust om beräkning endast görs
%för SV, men nu har jag inte lyckats extrahera dessa, så det blir lönlöst.
%notera att på slide 6 så g(x) = w^T*x+b. I vårt fall 
b = mean((Y(SVindex).*alpha(SVindex)'*K(SVindex,SVindex) - Y(SVindex)))

%Redan här verkar något vara lurt, för alpha(SVindex)'*K(SVindex,SVindex)
%är mycket större än 1, så Y har väldigt liten inverkan. 
%(Jag tycker det känns som det är teckenfel på b i sliden, därav den andra raden).

G =@(x) alpha(SVindex)'*kernel(X(:,SVindex),x) + b;
G =@(x) Y(SVindex).*alpha(SVindex)'*kernel(X(:,SVindex),x) + b;

SVindex = find(abs(alpha)>TOL);
test = Y(SVindex).*G(X(:,SVindex))-1; %Detta borde
%vara 0 för alla SV
max(test)
end

