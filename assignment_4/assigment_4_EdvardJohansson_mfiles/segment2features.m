function features = segment2features(I)
%Följande rader tar reda på området som är det minsta möjliga som
%innehåller hela bokstaven
[i, j] = find(I);
minRow = min(i);
minCol = min(j);
maxRow = max(i);
maxCol = max(j);
I = I(minRow:maxRow, minCol:maxCol);
[minM, minN] = size(I);
m = 11;
n = 10;
I = imresize(I, [m,n]);
check_size = 0;
if(minM < m && check_size)
    disp('m för stort, borde vara')
    disp(minM)
    pause;
end
if(minN < n && check_size)
    disp('n för stort, borde vara')
    disp(minN)
    pause;
end
%I = pca(I);
features = I(:);
%Fick tips av en person att en väldigt bra feature är helt enkelt bilden.
%Detta kunde man ju märka på uppgift faceNonFace, där featurevektorn var
%bilden.