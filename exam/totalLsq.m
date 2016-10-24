function abc = totalLsq(x, y)
%totalLsq Performs total least squares and returns a, b and c.
%   
sq = @(y) sqrt(sum(y.^2));
ytotalDiff = @(x, y, abc) abs(y*abc(2,:) +x*abc(1,:) + ones(size(x))*abc(3,:))*diag(1./(sqrt(abc(1,:).^2 + abc(2,:).^2)));

xbar = sum(x);
x2bar = x'*x;
ybar = sum(y);
xybar = x'*y;
y2bar = y'*y;
N = numel(x);
corn = xybar - xbar*ybar/N;
totalA = [x2bar - xbar^2/N, corn
            corn, y2bar - ybar^2/N];
[ab, d] = eig(totalA);
c = -1/N*(ab(1,:)*xbar+ab(2,:)*ybar);
y2totalDiff = ytotalDiff(x, y, [ab; c]);
y2totalDist = sq(y2totalDiff);
[y2totalDist,abInd] = min(y2totalDist);

abc = [ab(1,abInd), ab(2,abInd) c(abInd)];
end

