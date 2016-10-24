I = imread('testGauss.png');
I = imread('zebra.jpg');
%corr - testa punkt

bw = 1;
if bw
    I = rgb2gray(I);
end
I = double(I)/255;

std = 3;
N = max(ceil(6*std)+1, 20);
alpha = 1;
dy = [1;-1];
dx = [1 -1];
gauss = fspecial('gauss', [N N],std);

I1 = imfilter(I, gauss);
[Gx, Gy] = imgradientxy(I);
[I2, I4] = imgradient(Gx,Gy);
[Gx, Gy] = imgradientxy(I1);
[I3, I5] = imgradient(Gx,Gy);



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


m = 2;
n = 4;
figure(2);
subplot(m,n,1)
imshow(I);
imagesc(I);
subplot(m,n,2)
imshow(I1);
imagesc(I1);
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
