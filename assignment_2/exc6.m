n= 4;
test = ones(n,n);
blacks = [1 1; 2 2; 3 3; 4 2];
indexOfBlacks = blacks(:,1)+n*(blacks(:,2)-1);
%jag är säker på att detta kan göras mycket smartare, tipsa gärna om det!:)
test(indexOfBlacks) = 0; 

lineProb = [0.3, 0.2, 0.2, 0.3]';

eps = 0.2;

blacksInCollumn = sum(test == 0);
totalBlacks = sum(blacksInCollumn);

corrAndWrong = [blacksInCollumn' totalBlacks-blacksInCollumn'];

probs = (1-eps).^(corrAndWrong(:,1)+n*(n-1)-corrAndWrong(:,2)).*eps.^(n-corrAndWrong(:,1)+corrAndWrong(:,2));

px = probs'*lineProb;

postPri = probs.*lineProb/px;