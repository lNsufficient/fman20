function [ output_args ] = plotBoth(I, I2)
%PLOTBOTH Summary of this function goes here
%   Detailed explanation goes here
figure(1)
subplot(1,2,1)
if (max(max(imag(I))) > 0)
    I = fourierIm(I);
    disp('imag I')
end
image(I);
imagesc(I);
colormap('gray');
subplot(1,2,2)
image(I2);
imagesc(I2);
colormap('gray');
figure(2)
hist(I2(:))

end

