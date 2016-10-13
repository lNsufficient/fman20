function im = smoothmatrix(im)
%SMOOTHMATRIX Smooths the matrix
n = 3;
smoother = ones(n,n)/(n*n);
im = conv2(im, smoother, 'same');


end

