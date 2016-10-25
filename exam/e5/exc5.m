clear;
load('tentadata2016okt.mat')

%I will try to solve this using maxflow in order to segment the text. When
%that has been done I will try to extrapolate the image to the pieces where
%the text used to be. 
%The best solution would probably be too google for the actual image and
%see if it can be found, but I don't want to risk putting the image on the
%internet....


%image(inpaint)
I = inpaint;
%I = double(I)/255;
[m, n, o] = size(I);
% y = I(270, 341, :);
% y = I(357, 226, :);
y = zeros(1,1,3);
y(:,:,1) = 255;
y(:,:,2) = 255;
y(:,:,3) = 0;
 
%y(:,:,3) = 0; 
l1 = I(:,:,1) - y(:,:,1);
l2 = I(:,:,2) - y(:,:,2);
l3 = I(:,:,3) - y(:,:,3);

l1 = double(l1);
l2 = double(l2);
l3 = double(l3);

yellowNorm = sqrt(l1.^2+l2.^2+l3.^2);
% a1 = l1 == y(:,:,1);
% a2 = l2 == y(:,:,2);
% a3 = l3 == y(:,:,3);
maxYellowDist = 15.968715; %just by testing.
maxYellowDist = 20;
ind = find(yellowNorm < maxYellowDist);
%forgroundP = 

indI = [ind; ind+m*n; ind+m*n*2];
I(indI) = 0;

%IDEER:
%använd maxflow för att klassifiera.
%Du kan göra en sannolikhetsfunktion kring punkten 255, 255, 0;
%om talet är nära så har det stor sannolikhet att tillhöra siffrorna. 
%om talet är långt bort så har det liten sannolikhet att tillhöra
%siffrorna. 

%En annan tanke är att kolla på derivatan för området, och leta efter ett
%platt område, men jag tror inte det är lika bra. 

%I(:,:,1) = y(:,:,1);
%I(:,:,2) = y(:,:,2);
%I(:,:,3) = y(:,:,3);
%y = I(100, 755, :);

% overlap = findMatches(I, y);
% overlap = overlap(:,:,1) == 1;
% [m, n] = find(overlap == 1);
% I(m, n,:) = y*0;

image(I);

px = @(x) 1/(1+exp(x));
x = linspace(0,max(max(yellowNorm)));