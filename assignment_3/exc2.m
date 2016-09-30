load('FaceNonFace.mat');
part = cvpartition(200, 'HoldOut', 0.20);

[alpha, b, Xclass] = class_train(X(:,part.training), Y(:,part.training));
Yclassified = classify(X(:,part.test), alpha, b, Xclass)
correct = Yclassified - Y(:, part.test);