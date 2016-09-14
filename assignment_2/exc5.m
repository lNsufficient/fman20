pics{1} = [0, 0, 1; 0, 1, 0; 0, 0, 1; 0, 1, 0; 0, 0 , 1];
pics{2} = [1 0 1; 0 1 0; 0 1 0; 0 1 0; 1 0 1];
pics{3} = [1 0 1; 0 1 0; 1 0 1; 0 1 0; 1 0 1];

prob = [0.3, 0.4, 0.3];

eps = 0.5;

test = [1 1 1; 0 1 1; 1 0 1; 1 1 0; 0 0 1];

nbrPix = numel(test);
nbrCorrect = zeros(length(prob), 4);
%left collumn are white correct, right collumn are black correct.

for i = 1:length(prob)
    matches = (pics{i} == test);
    nbrCorrect(i, :) = [sum(sum(matches.*test)) sum(sum(matches.*(test==0))) sum(sum((matches==0).*(pics{i}==1))) sum(sum((matches==0).*(pics{i}==0)))]; 
end

epsWisB = 0.3;
epsBisW = 0.2;
pImForClass = (1-epsWisB).^nbrCorrect(:,1).*(1-epsBisW).^nbrCorrect(:,2).*epsWisB.^nbrCorrect(:,3).*epsBisW.^nbrCorrect(:,4);
pIm = pImForClass'*prob';
pClassForIm = pImForClass.*prob'/(pIm);