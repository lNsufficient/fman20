clear;
load('tentadata2016okt.mat')

I = edgy;
I = double(I)/255; %jag föredrar detta, så slipper man int. 

gaussEd = @(x,y,b) 1/(2*pi*b^2)*exp(-(x.^2+y.^2)/(2*b^2));
dxgaussEd = @(x,y,b) -2*x/(2*b^2).*gaussEd(x,y,b);

std = 60;
%Enligt https://en.wikipedia.org/wiki/Gaussian_blur så ska N vara ungefär
%6*std. Jag tar i lite extra för att garantera.
N = max(ceil(6*std)+1, 20);

[y, x] = ndgrid(-N:N,-N:N);
edGaussx = dxgaussEd(x,y,std);

figure(1);
subplot(2,2,1);
imagesc(I);
colormap('gray');
title('original image');

subplot(2,2,2);
imagesc(edGaussx);
colormap('gray');
title('Gauss scale space representation of dx')

pause;
Ig = conv2(I, edGaussx, 'same');
Ig = abs(Ig);
subplot(2,2,3);
imagesc(Ig);
colormap('gray');
title('after convolving with image filter');


std = 3;
N = max(ceil(6*std)+1, 20);
[y, x] = ndgrid(-N:N,-N:N);
edGaussx = dxgaussEd(x,y,std);

dx = [1, -1];
Ig2 = conv2(Ig, dx, 'same');
%Ig2 = abs(Ig2);
subplot(2,2,4)
imagesc(Ig2)
colormap('gray');
title('derivative of scale space representation of dx')

%%
figure(2);
m = 401;
subplot(2,2,1);
plot(Ig(m,:));
title('dx orig')
m

subplot(2,2,2);
plot(Ig2(m,:),'o');
title('dxdx');

subplot(2,2,3)
title('local maxima in x-directoin of the absolute value of dx')
TOL = 0.5e-6;
Ig3 = conv2(Ig2, dx, 'same');
n = size(Ig2, 2);
TOL2 = 0.4e-7; %används för att få bort inflektionspunkter
Ig_local_max = find((abs(Ig2) < TOL).*(Ig3 < -TOL2)); 
% local_m(local_n==1) = [];
% local_n(local_n==1) = [];
% local_m(local_n==n) = [];
% local_n(local_n==n) = [];
% 
% nn = numel(Ig);
% Ig_local = Ig_local(Ig_local < nn);
% Ig_local_max = Ig_local(Ig2(Ig_local-1)-Ig2(Ig_local+1) > 0); %this is incorrect right now
local_maxima = zeros(size(Ig2));
local_maxima(Ig_local_max) = 1;
imagesc(local_maxima);
colormap('gray');

Ig_Max = min(max(Ig,[],2)); %the maxima for each row in Ig is at least this big.
limit = Ig_Max*0.4;
Ig_local_cut = local_maxima.*(Ig>limit);
subplot(2,2,4);
imagesc(Ig_local_cut);

% subplot(2,2,4);
% plot(Ig3(m,:))

disp('about to save, ctrl-c or space')
pause;
save('e2data')

