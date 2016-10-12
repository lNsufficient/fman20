%get features and their ground truth.

%Detta stal jag från in2_test_and_benchmark.m:
mysystem.segmenter = 'im2segment'; % What is the name of your segmentation-algorithm.
mysystem.features = 'segment2features'; % What is the name of your features-algorithm.
datadir = '../datasets/short1';     % Which folder of examples are you going to test it on
[~,~,allX,allY]=benchmark_inl2(mysystem,datadir,0);

%Nu ska den tränas, jag tänker låta den tränas på all data till att börja
%med.
Xt = allX;
Yt = allY;

load('ocrsegments.mat')
Xf = zeros(49,100);
for i = 1:100
    x = S{i};
    Xf(:,i) = segment2features(x);
end
Yf = y;

Xtest = Xf;
Ytest = Yf;

model = cell(26,1);
for(i = 1:26)
    Yt = 2*(Ytest==i) - 1;
    %Xt = allX;
    model{i} = fitcsvm(Xtest', Yt');
end
classification_data = model;

save('classification_data', 'classification_data');
% i = 2;
% ypredict = predict(model{i}, allX');
% error = mean(ypredict' ~= (2*(allY==i)-1))

%In i classify skickar jag därefter alla modeller, så får alla de
%classifiera. Den som har 1 med minst error rate vinner, och får bestämma
%bokstav.
correct = 0;
for i = 1:length(Yt)
    Yr = features2class(Xtest(:,i), classification_data);
    correct= correct + (Yr == Yf(i));
end
error = 1 - correct/100;