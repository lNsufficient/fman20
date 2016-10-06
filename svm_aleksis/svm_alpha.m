function theta = svm_alpha(X, Y, C, sv_tol)
% Linear SVM for data in X with labels in Y.
% w' * x - b = 0 is the model, and we get w and b (theta = [w, b]) 
% 
% In this case, the way we get theta is different form the straighforward quadrog 
% approach (see svm.m). We instead solve the Lagrangian dual problem to find appropriate
% alphas, and after that we can get w and b. The optimization problem looks like this:
%
% max_{alpha}  sum_i alpha_i - 1/2 * sum_i sum_j alpha_i alpha_j y_i y_j x_i^T x_j
% s.t. alpha_i >= 0, sum_i alpha_i y_i = 0
%
% We begin by transforming it so that it looks like a default QP (note sign change when
% going from max to min):
%
% min_{alpha} 1/2 * alpha^T * H * alpha + (-1)^T alpha 
% s.t. -alpha <= 0 (elementwise), y^T * alpha = 0
%
% Note: the C parameter above is used in soft-margin SVM, in which case
% the inequality constraint for alpha becomes -C <= -alpha <= 0

% Default settings
if ~exist('C', 'var');      C      = nan;  end % Intepret as "use hard-margin"
if ~exist('sv_tol', 'var'); sv_tol = 1e-5; end

% Observe: X' * X in H below may be replaced via the kernel trick, to extend to
% nonlinear SVM

% Solve Dual Problem
n = size(X, 2); % Number of examples
H = (Y * Y') .* (X' * X); % Y^T*Y --> give sign, X^T*X --> give all x_i^T x_j pairs 
f = -ones(n, 1);
if isnan(C)
    A = -eye(n);
else
    A = zeros(n);
end
b     	  = zeros(n, 1);
Aeq   	  = zeros(n);
Aeq(1, :) = Y';
beq   	  = zeros(n, 1);
if isnan(C)
	alph = quadprog(H, f, A, b, Aeq, beq);
else
	lb   = zeros(n, 1);
	ub   = C * ones(n, 1);
	alph = quadprog(H, f, A, b, Aeq, beq, lb, ub);
end

% Now that we have found alpha, it's time to get w, b

% Find SV's
sv_idxs = find(abs(alph) < sv_tol);

% Compute w
X_sv      = X(:, sv_idxs);
Y_sv      = Y(sv_idxs);
alph_sv   = alph(sv_idxs);
alph_Y_sv = (alph_sv .* Y_sv)';
w 		  = sum(bsxfun(@times, X_sv, alph_Y_sv), 2);

% Compute b
b = mean(w' * X_sv - Y_sv');

test = Y_sv.*(w'*X_sv + b) - 1
% Return the SVM
theta = [w; b];
end