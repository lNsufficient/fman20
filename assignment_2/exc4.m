pics{1} = [0, 1; 1, 0];
pics{2} = [1, 0; 0, 1];
pics{3} = [1, 1; 1, 0];

prob = [1/4, 1/4, 1/2];

eps = 0.5;

test = [0, 1; 1, 1];

nbrPix = numel(test);
nbrCorrect = zeros(size(prob));

%Jag kunde inte komma på hur jag kunde göra följande utan for-loop, ge
%gärna tips! :)
for i = 1:length(prob)
    nbrCorrect(i) = sum(sum((pics{i} == test))); 
end

pImForClass = (1-eps).^nbrCorrect.*eps.^(nbrPix - nbrCorrect);
pIm = pImForClass*prob';
pClassForIm = pImForClass.*prob/(pIm);