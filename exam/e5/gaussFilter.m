function gf = gaussFilter(sigma)
%GAUSSFILTER Summary of this function goes here
%   Detailed explanation goes here
N = ceil(6*sigma)+1;
gf = fspecial('gaussian',[N N],sigma);


end

