function theta = svm(X, Y, bias_added)
% Linear SVM for data in X with labels in Y.
% w' * x - b = 0 is the model, and we get w and b (theta = [w, b]) 
%
% In this case we directly plug in the necessary stuff into quadprog (i.e., we
% don't go via the dual problem). The downside of this approach is that
% it can only be used in the linear setting, whereas in the dual approach 
% (see svm_alpha.m), it is easy to extend to nonlinear kernels via kernel trick.

% Default settings (assume X doesn't already contain the bias as last feature)
if ~exist('bias_added', 'var'); bias_added = false; end

% Possibly extend bias to end of each feature vector
if ~bias_added
	X = [X; ones(1, size(X, 2))];
end

% m = number of features = dim(theta)
% n = number of examples

[m, n] 					= size(X); 
H      					= zeros(m, m);
H(1 : m - 1, 1 : m - 1) = eye(m - 1);
f      				    = zeros(m, 1);
Y_rep 				    = repmat(Y, 1, m);
XY     				    = Y_rep .* X';
A      					= -XY;
b      					= -ones(n, 1);
theta  					= quadprog(H, f, A, b);

end