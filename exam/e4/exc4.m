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
disp('=======A======')
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

%[mu0, sigma0]= estimateGauss(X0, 1);
[mu0, sigma0]= estimateGauss(X0);
%[mu1, sigma1]= estimateGauss(X1, 1);%båda stämmer väl med histogrammen
[mu1, sigma1]= estimateGauss(X1);

%söker nu hitta värde p(x tillhör klass j | x) (skrivs nu p(y = j | x). 
%För detta används bayes rule, p(y=j|x) = p(x|y=j)*p(y=j)/p(x).
%p(x) är samma för båda, så den behöver bara beräknas om jag vill veta
%sannolikheten. Jag vill dock bara veta vilken som har störst sannolikhet.
%p(y=j) är 0.5 för båda, så denna kan vi också strunta i. Nu återstår bara
%att beräkna p(x|y=j). 

pxForClass0 = normpdf(x,mu0,sigma0);
pxForClass1 = normpdf(x,mu1,sigma1);

%nu finns sannolikhet för sex olika tal. Hur stor är sannolikheten att x
%tillhör den givna klassen. p(xi | classj) = normpdf(xi, muji, sigmaj), 
%p(x | classj) = p(x1 | classj) and p(x2 | classj) and...and p(x6 | classj)
%Eftersom dessa var oberoende av varandra kan detta enkelt beräknas:

pxClass0 = prod(pxForClass0);
pxClass1 = prod(pxForClass1);

%normerar för att få snyggare sannolikheter:
px = pxClass0 + pxClass1;

pxClass0 = pxClass0/px;
pxClass1 = pxClass1/px;

disp('=====B, C=====')
mu0_and_mu1 = [mu0, mu1]
sigma0_and_sigma1 = [sigma0, sigma1]
str = sprintf('p(y=0|x) = %3f, p(y=1|x) = %3f', pxClass0, pxClass1);
disp(str)
disp('Det är alltså mest troligt att x är av klass 0');