clear;
load('tentadata2016okt.mat')
%image(inpaint)
I = inpaint;
%I = double(I)/255;
[m, n, o] = size(I);
y = I(270, 341, :);
y = I(357, 226, :);
 
%y(:,:,3) = 0; 
l1 = I(:,:,1);
l2 = I(:,:,2);
l3 = I(:,:,3);
a1 = l1 == y(:,:,1);
a2 = l2 == y(:,:,2);
a3 = l3 == y(:,:,3);
ind = find(a1.*a2.*a3==1);
indI = [ind; ind+m*n; ind+m*n*2];
I(indI) = 0;

%IDEER:
%använd maxflow för att klassifiera.
%Du kan göra en sannolikhetsfunktion kring punkten 255, 255, 0;
%om talet är nära så har det stor sannolikhet att tillhöra siffrorna. 
%om talet är långt bort så har det liten sannolikhet att tillhöra
%siffrorna. 

%I(:,:,1) = y(:,:,1);
%I(:,:,2) = y(:,:,2);
%I(:,:,3) = y(:,:,3);
%y = I(100, 755, :);

% overlap = findMatches(I, y);
% overlap = overlap(:,:,1) == 1;
% [m, n] = find(overlap == 1);
% I(m, n,:) = y*0;

image(I);