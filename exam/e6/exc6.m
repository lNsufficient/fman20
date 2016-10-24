clear;
load('tentadata2016okt.mat')

I = im;

x = 141;
y = 22;
s = 6;
I_small = I(x-s:x+s, y-s:y+s);

figure(1)
imagesc(I);

figure(2)
imagesc(I_small);