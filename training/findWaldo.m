makebw = 1;

I = imread('waldo_small.jpg');
if makebw
    I = rgb2gray(I);
end
I = double(I)
%I = magic(100);
a = 50;
b = 40;
s = 50;
topLeft = [a, b];
botRight = [a+s, b+s];
%botRight = [500, 400];
%topLeft = [2, 2];
%botRight = [2,2];
leftLim = topLeft(1);
topLim = topLeft(2);
rightLim = botRight(1);
botLim = botRight(2);
corr_m = (botLim+topLim)/2;
corr_n = (rightLim+leftLim)/2;
imPoints = ndgrid(leftLim:rightLim, topLim:botLim);
cropLimits = [leftLim, topLim, rightLim-leftLim, botLim-topLim];
waldo = imcrop(I, cropLimits);
patch = fliplr(flipud(waldo));
figure(1);
image(I)
imagesc(I)
if makebw
colormap('gray');
end
figure(2)
image(waldo);
imagesc(waldo);
if makebw
colormap('gray');
end
figure(3)
image(patch);
imagesc(patch);
if makebw
    colormap('gray')
end
AA = sum(sum(patch.*patch));
if makebw == 0
    AA = sum(AA)
end
BBt = I.*I;

% [patch_m, patch_n] = size(waldo);
% [I_m, I_n] = size(I);
% cols = I_n-patch_n;
% rows = I_m-patch_m;
% correlation = zeros(rows, cols);
% for i = 1:(I_n-patch_n)
%     for j=1:(I_m-patch_m)
%         tmpI = imcrop(I,[i,j,patch_n-1,patch_m-1]);
%         correlation(i,j) = corr2(waldo,tmpI);
%     end
% end


if makebw
    BB = conv2(BBt,ones(size(patch)),'valid');
    AB = conv2(I,patch,'valid');
else
    BB = convn(BBt,ones(size(patch)),'valid');
    AB = convn(I,patch,'valid');
end
res = AA - 2*AB + BB;
[vals, m] = min(res);
[~, n] = min(vals);
m = m(n);
[m_I, n_I] = size(I);
[m_conv, n_conv] = size(AB);
edge_m = (m_I - m_conv)/2;
edge_n = (n_I - n_conv)/2;
found_m_n = [m+edge_m n+edge_n]
corr_m_n = [corr_m corr_n]

%res = (-res).^4;
figure(4)
image(res)
imagesc(res)
if makebw
colormap('gray')
end