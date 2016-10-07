function [S] = im2segment(im)
% [S] = im2segment(im)

%trying to do something about the contrast. An idea is to do this in "many"
%different ways, one which just splits at half of max brightness, one which
%splits at the median of the whole brightness when excluding the darkest
%and brightest pixels.
minBright = min(min(im));
im = im - minBright;
maxBright = max(max(im));

imC = (im < (maxBright/2));

%finding the letters
imL = bwlabel(imC,8);

%try to see approx how many pixels that correspond to each island 
%to be able to remove small islands. No small islands usually found...
nbrIslands = max(max(imL));
% disp(nbrIslands);
% image(imL);
% imagesc(imL);
% colormap(gray);

islandHistogram = zeros(nbrIslands, 2);
for i = 1:nbrIslands
    nbrHits = sum(sum(imL==i));
    islandHistogram(i,1) = i;
    islandHistogram(i,2) = nbrHits;
end

smallIsl = 5;
[smallIslands, ~] = find(islandHistogram(:,2) < smallIsl);

bigIslands = 1:nbrIslands;
%disp(bigIslands);
bigIslands = setdiff(bigIslands,smallIslands);

nrofsegments = length(bigIslands);

%find outermost pixels for each letter

limits = [bigIslands', zeros(length(bigIslands),4)];
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
limitCols = zeros(length(bigIslands), 1);
limitCols(1) = 0; %not necessary

limitCols(2:end) = (limits(1:end-1,3) + limits(2:end, 2))/2;

%decrease contrast slightly and find islands within the limitCols is a
%possibillity, but I found that the score was great no matter if that was
%done. If improvement is needed, this is a possibillity.

for kk = 1:nrofsegments;
    S{kk}= (imL == bigIslands(kk));
end;
end
