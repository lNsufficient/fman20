clear;
load('FaceNonFace.mat');
part = cvpartition(200, 'HoldOut', 0.20);

[alpha, b, Xclass, G] = class_train(X(:,part.training), Y(:,part.training));
testIndices = part.training;
Yclassified = classify(X(:,testIndices), alpha, b, Xclass, G);
correct = (Yclassified == Y(:, testIndices));
sum(correct)