clear;
load('tentadata2016okt.mat');

%% a
%K nearest neighbours implementerad enligt:
%föreläsningsslide: f05_machine_learning_1.pdf

k = 5;
x = x';
[k_closest] = shortestDist(x, X, k);
class = classVote(k_closest, Y);
str = sprintf('%d nearest neighbours tilldelade x klassen %d',k,class);
disp(str)

%% b

%börjar med att dela upp i klasser.
y1 = find(Y==1);
y0 = find(Y==0);

X1 = X(:,y1);
X0 = X(:,y0);

% figure(1);
% for i = 1:6
%     subplot(3,2,i)
%     hist(X0(i,:))
% end
% figure(2);
% subplot(2,1,1)
% hist(X1(:))
% subplot(2,1,2)
% hist(X0(:))

[mu0, sigma0]= estimateGauss(X0, 1);
[mu1, sigma1]= estimateGauss(X1, 1);%båda stämmer väl med histogrammen

pxForClass0 = normpdf(x,mu0,sigma0);
pxForClass1 = normpdf(x,mu1,sigma1);

%nu finns sannolikhet för sex olika tal. Hur stor är sannolikheten att x
%tillhör den givna klassen. p(xi | classj) = normpdf(xi, muji, sigmaj), 
%p(x | classj) = p(x1 | classj)