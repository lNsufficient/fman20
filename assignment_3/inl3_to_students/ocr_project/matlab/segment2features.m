function features = segment2features(I)
%Följande rader tar reda på området som är det minsta möjliga som
%innehåller hela bokstaven
[i, j] = find(I);
minRow = min(i);
minCol = min(j);
maxRow = max(i);
maxCol = max(j);
I = I(minRow:maxRow, minCol:maxCol);
I = imresize(I, [6, 6]);
features = I(:);
%Fick tips av en person att en väldigt bra feature är helt enkelt bilden.
%Detta kunde man ju märka på uppgift faceNonFace, där featurevektorn var
%bilden.