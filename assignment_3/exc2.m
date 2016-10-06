clear;
load('FaceNonFace.mat');

nbrRuns = 19;
stats = zeros(nbrRuns, 2);
for(i = 1:nbrRuns)
    part = cvpartition(200, 'HoldOut', 0.20);

    g = class_train(X(:,part.training), Y(:,part.training));
    Yclassified = classify(X,g);

    correct = (Yclassified == Y);
    correct_training = mean(correct(part.training));
    correct_test = mean(correct(part.test));
    
    stats(i,:) = [correct_training correct_test];
end
correct_training = mean(stats(:,1))
correct_test = mean(stats(:,2))

error_rates = [1 - correct_training, 1 - correct_test]

%Plot face
tI = part.test;
Xtest = X(:,tI);
[~, firstFace] = find(Y(tI)==1,1);
facePic = vec2mat(Xtest(:,firstFace), 19);
facePic = facePic';
image(facePic);
imagesc(facePic);
colormap('gray');
face = classify(Xtest(:,firstFace),g)
pause;

[~, firstNonFace] = find(Y(tI)==-1, 1);
nonfacePic = vec2mat(Xtest(:,firstNonFace),19);
nonfacePic = nonfacePic';
image(nonfacePic);
imagesc(nonfacePic);
colormap('gray');
nonface = classify(Xtest(:,firstNonFace),g)
