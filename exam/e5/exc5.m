clear;
load('tentadata2016okt.mat')
addpath(genpath('maxflow')); %Jag använder samma fkn som i assignment 4.

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
l1 = (double(I(:,:,1)) - double(y(:,:,1)));
l2 = double(I(:,:,2)) - double(y(:,:,2));
l3 = double(I(:,:,3)) - double(y(:,:,3));

l1 = double(l1);
l2 = double(l2);
l3 = double(l3);

yellowNorm = sqrt(l1.^2+l2.^2+l3.^2);
% a1 = l1 == y(:,:,1);
% a2 = l2 == y(:,:,2);
% a3 = l3 == y(:,:,3);
maxYellowDist = 15.968715; %just by testing.
maxYellowDist = 130;
x0 = maxYellowDist;
k = 0.09;
pbg = @(x) 1./(1+exp(-k*(x - x0)));
py = @(x) 1-pbg(x);

Py = py(yellowNorm);
Pbg = pbg(yellowNorm);
[m, n] = size(yellowNorm);
neighbours = edges4connected(m, n);
i = neighbours(:,1);
j = neighbours(:,2);
nu = 4;
A = sparse(i, j, nu, m*n, m*n);
T = [-log(Pbg(:)), -log(Py(:))];
% T = T.^(1/4);
fac = 10; 
exp = 4;
%T = [(Pbg(:)+1), (Py(:)+1)];
%T = fac*T.^exp;
T = sparse(T);
[e, theta] = maxflow(A, T);
theta = reshape(theta, m, n);
theta = double(theta);
invTheta = theta == 0;

ind = find(yellowNorm < maxYellowDist);
SE = strel('disk',2,0); %Det var nog bättre att ta bort lite för mycket
%det hade varit dåligt om det blev en gul kant runt, för då kommer det gula
%tillbaka då man smetar ut det övriga där det tidigare var gult.
theta2 = imdilate(invTheta, SE);
ind = find(theta2 == 1);
%forgroundP = 

indI = [ind; ind+m*n; ind+m*n*2];
Icopy = I;
Icopy(indI) = 0;

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

figure(1);
subplot(2,2,1)
image(Icopy);
subplot(2,2,2)
imagesc(Py);
colormap('gray')
subplot(2,2,3)
imagesc(theta);
subplot(2,2,4);
x = linspace(0,255);
y = py(x);
plot(x, y)

%% Nu har jag lyckats hitta theta2, som ger mig hela det gula text-området.
%  Nästa steg är nu att försöka smeta ut den övriga bilden på det gula.
npatch = 80;
patch = ones(1,npatch);
edges = 5;
patch(edges:npatch-edges) = 0;
patch = patch/sum(patch);
Ipatch = maskedFilter(I, indI, patch);
figure(2)
subplot(2,2,1)
image(Icopy);
subplot(2,2,2)
image(Ipatch);
Ipatch2 = maskedFilter(Ipatch, indI, patch');
subplot(2,2,3)
image(Ipatch2);
subplot(2,2,4)
patch = eye(npatch);
patch(edges:npatch-edges, edges:npatch-edges) = 0;
patch = patch/sum(sum(patch));
Ipatch3 = maskedFilter(Ipatch2, indI, patch);
patch = flipud(patch);
Ipatch3 = maskedFilter(Ipatch3, indI, patch);
image(Ipatch3)


%%

Igauss = gaussFilter(I,100);

IgaussMasked = I;
IgaussMasked(indI) = Igauss(indI);
Igauss2 = gaussFilter(IgaussMasked,20);
IgaussMasked2 = I;
IgaussMasked2(indI)= Igauss2(indI);

figure(2)
subplot(2,2,1)
image(Icopy);
subplot(2,2,2)
image(IpatchMasked);
subplot(2,2,3)
image(IgaussMasked);
subplot(2,2,4)
image(IgaussMasked2);