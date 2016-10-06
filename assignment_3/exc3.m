load('ocrfeaturestrain.mat');
h = hist(Y, 26);


[cs, c] = max(h);
h(c) = -cs;
[os, o] = max(h);
h(o) = -os;
c = 3; %3 - C,
o = 15; % 15 - O.

cIndices = find(Y == c); 
oIndices = find(Y == o); 

ocIndices = union(cIndices, oIndices);
X = X(:,ocIndices);
Y = Y(:,ocIndices);
Y = (Y == c)*2 - 1; %1 för c, -1 för o.

N = length(ocIndices);

nbrRuns = 200;
allRuns = zeros(nbrRuns, 3);
allRuns_c = zeros(nbrRuns, 3);
for(i = 1:nbrRuns)
    part = cvpartition(N, 'HoldOut', 0.20);
    Xtrain = X(:,part.training);
    Ytrain = Y(:,part.training);
    Xtest = X(:,part.test);
    Ytest = Y(:,part.test);

    tree = fitctree(Xtrain', Ytrain');
    SVMModel = fitcsvm(Xtrain', Ytrain');
    mdl = fitcknn(Xtrain', Ytrain');

    y1_c = predict(tree, Xtrain');
    y2_c = predict(SVMModel, Xtrain');
    y3_c = predict(mdl, Xtrain');
    
    y1 = predict(tree, Xtest');
    y2 = predict(SVMModel, Xtest');
    y3 = predict(mdl, Xtest');
    
    correct_c = mean([Ytrain' == y1_c, Ytrain'==y2_c, Ytrain'==y3_c]);
    correct = sum([Ytest' == y1, Ytest'==y2, Ytest'==y3])/length(Ytest);
    allRuns_c(i,:) = correct_c;
    allRuns(i,:) = correct;
end
medelfel = 1 - mean(allRuns)
medelfel_c = 1 - mean(allRuns_c)
Ytest