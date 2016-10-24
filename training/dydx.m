I = imread('testGauss.png');
I = imread('zebra.jpg');
%corr - testa punkt

bw = 1;
if bw
    I = rgb2gray(I);
end
I = double(I)/255;

std = 3;
N = max(3*ceil(6*std)+1, 20);
alpha = 1;
dy = [1;-1];
dx = [1 -1];
lap = fspecial('laplacian', alpha);
log = fspecial('log',[N N],std);
gauss = fspecial('gauss', [N N],std);
lapgauss = imfilter(gauss,lap);
gausslap = imfilter(lap,gauss);
dxgauss = imfilter(gauss,dx);
dygauss = imfilter(gauss,dy);
dxdygauss = imfilter(dygauss,dx);
dydxgauss = imfilter(dxgauss,dy);

figure(1)
mf = 2;
nf = 3;
subplot(mf,nf,1)
imshow(gauss);
imagesc(gauss);
subplot(mf,nf,2)
imshow(lap);
imagesc(lap);
subplot(mf,nf,3)
imshow(log);
imagesc(log);
subplot(mf,nf,4)
imshow(lapgauss);
imagesc(lapgauss);
subplot(mf,nf,5)
imshow(gausslap);
imagesc(gausslap);

I1 = imfilter(I, gauss);
I2 = imfilter(I, dygauss);
I3 = imfilter(I, dxgauss);
I4 = imfilter(I, dxdygauss);
I5 = imfilter(I, dydxgauss);

gaussEd = @(x,y,b) 1/(2*pi*b^2)*exp(-(x.^2+y.^2)/(2*b^2));
dxgaussEd = @(x,y,b) -2*x/(2*b^2).*gaussEd(x,y,b);
dygaussEd = @(x,y,b) -2*y/(2*b^2).*gaussEd(x,y,b);
dxdygaussEd = @(x,y,b) -2*y/(2*b^2).*dxgaussEd(x,y,b);


[y, x] = ndgrid(-N:N,-N:N);
edGauss = dxdygaussEd(x,y,std);
edGaussx = dxgaussEd(x,y,std);

I6 = imfilter(I, edGaussx);
I7 = imfilter(I, edGauss);

m = 2;
n = 4;
figure(2);
subplot(m,n,1)
imshow(I);
imagesc((edge(I)));
subplot(m,n,2)
imshow(I1);
imagesc(edge(I1));
subplot(m,n,3)
imshow(I2);
imagesc(I2);
subplot(m,n,4)
imshow(I3);
imagesc(I3);
subplot(m,n,5)
imshow(I4);
imagesc(I4);
subplot(m,n,6)
imshow(I5);
imagesc(I5);
subplot(m,n,7)
imshow(I6);
imagesc(I6);
subplot(m,n,8)
imshow(I7);
imagesc(I7);
