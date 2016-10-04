load('ocrfeaturestrain.mat');
h = hist(Y, 26);

c = 3; %3 - C,
o = 15; % 15 - O.
[cs, c] = max(h);
h(c) = -cs;
[os, o] = max(h);
h(o) = -os;

cIndices = find(Y == c); 
oIndices = find(Y == o); 

ocIndices = union(cIndices, oIndices);
X = X(:,ocIndices);
Y = Y(:,ocIndices);
Y = (Y == c)*2 - 1; %1 för c, -1 för o.

N = length(ocIndices);

part = cvpartition(N, 'HoldOut', 0.20);
Xtrain = X(:,part.training);
Ytrain = Y(:,part.training);
Xtest = X(:,part.test);
Ytest = Y(:,part.test);

tree = fitctree(Xtrain', Ytrain');
SVMModel = fitcsvm(Xtrain', Ytrain');
mdl = fitcknn(Xtrain', Ytrain');

y1 = predict(tree, Xtest');
y2 = predict(SVMModel, Xtest');
y3 = predict(mdl, Xtest');

correct = sum([Ytest' == y1, Ytest'==y2, Ytest'==y3])/length(Ytest)
Ytest