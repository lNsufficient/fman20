clear;
load('tentadata2016okt.mat');
I = double(blood)/255;

figure(4)
clf
imagesc(I)
colormap('gray')

[m, n] = size(I);
[y, x] = ndgrid(1:m,1:n); %origo bottom left corner

%guessing for a function describing intensity of background;
alpha = 13;
%alpha = 45;
r = n/cosd(alpha);
t = linspace(0,r);

xs = t*cosd(alpha);
ys = t*sind(alpha);

hold on;
plot(xs, ys, 'r')

xt = 50;
yt = 250;
plot(xt,yt,'or')

theta = atand(yt/xt);
l = sqrt(xt^2+yt^2);
t0 = l*cosd(alpha-theta);

xt2 = t0*cosd(alpha);
yt2 = t0*sind(alpha);

plot(xt2, yt2,'og');
gradientLine = @(x, y) a*x + b*y;  

%%

figure(3);
subplot(2,3,1)
imagesc(I)
colormap('gray')


%Segmentering med hjälp av bara en threshold funkade inte, så jag testar
%att göra olika för olika kolonner i bilden, man ser ju att den skiftar i
%ljus. 
meanIntensity = mean(I);

thresIm = zeros(size(I));
n = size(I, 2);
for j = 1:n
    thresIm(:,j) = I(:,j) < meanIntensity(j);
end


% n = 30;
% m = n;
% smooth = 1/(n*m)*ones(m,n);
% Ig = conv2(I, smooth);
subplot(2,3,2)
imagesc(thresIm);


R = 7;
N = 0;
SE = strel('disk',R,N);
morph1 = imopen(thresIm, SE);
subplot(2,3,3)
imagesc(morph1);

R = 5;
N = 0;
SE = strel('disk',R,N);
morph2 = imerode(morph1, SE);
subplot(2,3,4);
imagesc(morph2);

subplot(2,3,5);
R = 5;
N = 0;
SE = strel('disk',R,N);
morph3 = imerode(morph2, SE);
imagesc(morph3)

subplot(2,3,6);
R = 10;
N = 0;
SE = strel('disk',R,N);
morph4 = imerode(morph1, SE);
imagesc(morph4)



