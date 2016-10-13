function [S] = im2segment(im)
% [S] = im2segment(im)
imo = im;
%trying to do something about the contrast. An idea is to do this in "many"
%different ways, one which just splits at half of max brightness, one which
%splits at the median of the whole brightness when excluding the darkest
%and brightest pixels.
minBright = min(min(im));
im = im - minBright;
maxBright = max(max(im));
brightCoeff = 0.5;
for ij = 1:2
limitCoeff = 1/2*brightCoeff^(ij - 1);
imC = (im < (maxBright*limitCoeff));

%finding the letters
imL{ij} = bwlabel(imC,8);

%try to see approx how many pixels that correspond to each island 
%to be able to remove small islands. No small islands usually found...
nbrIslands = max(max(imL{ij}));
% disp(nbrIslands);
% image(imL);
% imagesc(imL);
% colormap(gray);

islandHistogram = zeros(nbrIslands, 2);
for i = 1:nbrIslands
    nbrHits = sum(sum(imL{ij}==i));
    islandHistogram(i,1) = i;
    islandHistogram(i,2) = nbrHits;
end

smallIsl = 5;
[smallIslands, ~] = find(islandHistogram(:,2) < smallIsl);

bigIslands{ij} = 1:nbrIslands;
%disp(bigIslands);
bigIslands{ij} = setdiff(bigIslands{ij},smallIslands);

end
bigIslands = bigIslands{1};
imL = imL{1};

imS = smoothmatrix(imL);

imS = bwlabel(imS, 8);
if(max(max(imS))~=5)
    disp('imS does not have 5 islands')
end
histimS = hist(imS(:), 0:max(max(imS)));
histimS(1)= [];
smallIslandsimS = find(histimS < smallIsl);
bigIslandsimS = 1:max(max(imS));
bigIslandsimS = setdiff(bigIslandsimS, smallIslandsimS);

%merge together the segmentation and the smoothed segmentation:
ij = 1;
intersections = zeros(length(bigIslandsimS), length(bigIslands));
for ik = 1:length(bigIslands)
    for ik2 = 1:length(bigIslandsimS)
        intersections(ik2, ik)= sum(sum((imS == (bigIslandsimS(ik2))).*(imL == (bigIslands(ik)))));
    end
end
[newLabeled, newLabels] = matchIslands(intersections, imL, bigIslands);

nrofsegments = length(newLabels);
if(nrofsegments ~= 5)
    disp('Fel antal segments');
end

%find outermost pixels for each letter

limits = [newLabels, zeros(length(newLabels),4)];
% limits = Islandnbr, leftmost, rightmost, topmost, bottommost
% indices for pixels
for i = bigIslands
    currentRow = find(limits(:,1)==i);
    [I, J] = find(imL == i);
    limits(currentRow, 2) = min(J);
    limits(currentRow, 3) = max(J);
    limits(currentRow, 4) = min(I);
    limits(currentRow, 5) = max(I);
end

%try to find collumns for division of the picture. Sort after leftmost
%pixel
[~, I] = sort(limits(:,2));
limits = limits(I,:);

%assuming that there is no overlap, we now know the order of the letters so
%the limits should be easy to calculate.
limitCols = zeros(length(newLabels), 1);
limitCols(1) = 0; %not necessary

limitCols(2:end) = (limits(1:end-1,3) + limits(2:end, 2))/2;

%decrease contrast slightly and find islands within the limitCols is a
%possibillity, but I found that the score was great no matter if that was
%done. If improvement is needed, this is a possibillity.

for kk = 1:nrofsegments;
    S{kk}= (newLabeled == newLabels(kk));
end;
end
