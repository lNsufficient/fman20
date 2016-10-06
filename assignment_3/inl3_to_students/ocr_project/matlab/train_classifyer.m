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

model = cell(26);
for(i = 1:26)
    Yt = 2*allY(allY==i) - 1;
    Xt = allX;
    model{i} = fitcsvm(Xtrain', Ytrain');
end

%In i classify skickar jag därefter alla modeller, så får alla de
%classifiera. Den som har 1 med minst error rate vinner, och får bestämma
%bokstav.