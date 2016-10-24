function abc = fitCurve(xs, ys)
%FITCURVE returns abc for the curve a*x+b*y+c = 0 so that it fits xs and ys
%   xs = [x1, x2];
%   ys = [y1, y2];
%   abc is a vector,
%   abc(1) = a;
%   abc(2) = b = -1;
%   abc(3) = c;

abc = zeros(3,1);
abc(2) = -1;
abc(1) = (ys(1)-ys(2))/(xs(1) - xs(2));
abc(3) = ys(1) - abc(1)*xs(1);

c2 = ys(2) - abc(1)*xs(2);

TOL = 1e-8;
cdiff = abc(3) - c2;
if abs(cdiff) > TOL
    disp('cdiff too big:')
    cdiff
end
end

