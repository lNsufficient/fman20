I = imread('testGauss.png');

bw = 1;
if bw
    I = rgb2gray(I);
end
I = double(I)/255;

%# Create the gaussian filter with hsize = [5 5] and sigma = 2
std = 30;
N = ceil(6*std)+1;
if bw
G = fspecial('gaussian',[N N],std);
else
    G = zeros(N,N,3);
    G(:,:,1) = fspecial('gaussian', [N, N], std);
    G(:,:,2) = G(:,:,1);
    G(:,:,3) = G(:,:,1);
    G = fspecial('gaussian', [N N] , std);
end
max(max(G))/min(min(G))
%# Filter it
if bw
%Ig = imfilter(I,G,'same');
disp('Conv2 process');
Ig = conv2(I, G, 'same');
disp('Imfilter process');
Ig2 = imfilter(I,G,'same');
else
    Ig = zeros(size(I));
    for i = 1:3
        Ig(:,:,i) = convn(I(:,:,i), G, 'same');
    end
    Ig2 = imfilter(I,G,'same');
end


%# Display
subplot(2,3,1)
%imshow(I);
image(I)
imagesc(I);
subplot(2,3,4)
%imshow(Ig)
image(Ig)
imagesc(Ig)
subplot(2,3,2)
imshow(G)
imagesc(G)
subplot(2,3,5)
imshow(Ig2)
imagesc(Ig2)
subplot(2,3,6)
if bw
    Ig3 = imgaussfilt(I,std);
    imshow(Ig3);
    imagesc(Ig3);
else
    Ig3 = (imgaussfilt3(I,std));
    imshow(Ig3);
    imagesc(Ig3);
end