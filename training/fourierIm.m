function If = fourierIm(If, c)
%FOURIERIM Summary of this function goes here
%   Detailed explanation goes here
if nargin <2
c = 1;
end
If = c*log(1+abs(If));

end

