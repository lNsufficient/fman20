clc;
close all;
clearvars;

% SVM toy problem

% Positives
x1 = [1;0]; % SV (pos)
x2 = [2;1]; % SV (pos)
x3 = [2;0]; % non-SV (pos)

% Negatives
x4 = [0;1]; % SV (neg)
x5 = [1;2]; % SV (neg)
x6 = [0;2]; % non-SV (neg)

% Form X,Y
X = [x1,x2,x3,x4,x5,x6];
Y = [1;1;1;-1;-1;-1];

% Run both svm's
theta_1 = svm(X,Y) 		 % optional third input: logical bias_added (false by default)
theta_2 = svm_alpha(X,Y) % optional third input: C >= 0 in soft-margin (hard-margin by default)
						 % optional fourth input: sv_tol (to get indexes of support vectors, 1e-5 by default)
                         
theta_E = class_train(X, Y');