clear;
load('tentadata2016okt.mat');
I = double(blood)/255;

figure(4)
clf
subplot(2,2,1);
imagesc(I)
colormap('gray')

[m, n] = size(I);
[y, x] = ndgrid(1:m,1:n); %origo bottom left corner

%guessing for a function describing intensity of background;
alpha = 15;
%alpha = 45;
r = n/cosd(alpha);
t = linspace(0,r);

xs = t*cosd(alpha);
ys = t*sind(alpha);

hold on;
plot(xs, ys, 'r')

startArea = I(1:13, 1:35);
t0 = mean(mean(startArea));
t0 = 0.5367; %intensitet i övre vänstra hörnet
t0 = 0.475


endArea = I(100:130, 488:503);
tf = mean(mean(endArea))
tf = 0.78;
%tf = 0.9284;

t0 = 0.48;
tf = 0.76955;
tf = 0.7695;
tf = 0.77

m = t0;
k = (tf - m)/r;
intensity_f = @(t) m+k*t;

ls = sqrt(x.^2 + y.^2);
thetas = atand(y./x);
ts = ls.*cosd(alpha-thetas);
intensityIm = intensity_f(ts);

xt = 50;
yt = 250;
plot(xt,yt,'or')

theta = atand(yt/xt);
l = sqrt(xt^2+yt^2);
t0 = l*cosd(alpha-theta);

xt2 = t0*cosd(alpha);
yt2 = t0*sind(alpha);

plot(xt2, yt2,'og');

subplot(2,2,2)
imagesc(intensityIm)
colormap('gray');

subplot(2,2,3)
segmented = (I < intensityIm);
imagesc(segmented)
colormap('gray')

subplot(2,2,4)
imagesc(endArea);
colormap('gray')

gradientLine = @(x, y) a*x + b*y;  

%%

figure(3);
subplot(2,2,1)
imagesc(segmented)
colormap('gray')


%Segmentering med hjälp av bara en threshold funkade inte, så jag testar
%att göra olika för olika kolonner i bilden, man ser ju att den skiftar i
%ljus. 
% % meanIntensity = mean(I);
% % 
% % thresIm = zeros(size(I));
% % n = size(I, 2);
% % for j = 1:n
% %     thresIm(:,j) = I(:,j) < meanIntensity(j);
% % end


% n = 30;
% m = n;
% smooth = 1/(n*m)*ones(m,n);
% Ig = conv2(I, smooth);
subplot(2,2,2)
inverseSegmented = segmented == 0;
imagesc(inverseSegmented);

subplot(2,2,3)
inverseLabels = bwlabel(inverseSegmented,8);
maxIsland = max(max(inverseLabels));
h = hist(inverseLabels(:), 1:maxIsland);
[~, bgLabel] = max(h);
background = inverseLabels == bgLabel;
blackBg = (background==0);
imagesc(blackBg);
colormap('gray')



R = 2;
N = 0;
SE = strel('disk',R,N);
SE = strel('diamond',R);
morph = blackBg;
%morph = imopen(blackBg, SE);
R = 2;
N = 0;
SE = strel('diamond',R);
morph = imerode(morph, SE);
R = 2;
N = 0;
SE = strel('diamond',R);
morph = imerode(morph, SE);
R = 1;
N = 0;
SE = strel('disk',R,N);
SE = strel('diamond',R);
%morph = imopen(blackBg, SE);
subplot(2,2,4)
imagesc(morph);



% SE = strel('disk',R,N);
% %SE = strel('cube',R);
% %SE = strel('diamond',R);
% morph = imopen(segmented, SE);
% subplot(2,2,4)
% imagesc(morph);

% subplot(2,3,5);
% R = 1;
% N = 0;
% SE = strel('disk',R,N);
% morph = imerode(segmented, SE);
% imagesc(morph)
% 
% subplot(2,3,6);
% R = 1;
% N = 0;
% SE = strel('disk',R,N);
% morph4 = imopen(morph, SE);
% imagesc(morph4)



