function I = closing(I, SE)
%CLOSING morphological closing by first dilation, then erosion
% Some neighbouring element SE is needed.

I = imdilate(I, SE);
I = im


end

