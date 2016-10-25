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

figure(1);
for i = 1:6
    subplot(3,2,i)
    hist(X0(i,:))
end

[m0, sig0] = normfit(X0');
