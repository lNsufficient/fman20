clear;
load('linjepunkter_1.mat');
x = x';
y = y';
ata = [x'*x, sum(x); sum(x), numel(x)];
aty = [x'*y; sum(y)];
kl1 = ata\aty;
y1vals = kl1(1)*x + kl1(2);
ydiffsq = @(y, yvals) abs(yvals - y);
y1diff = ydiffsq(y, y1vals);
%ytotalDiff = @(x, y, kl) abs(y*ones(size(kl(1,:))) -x*kl(1,:) - ones(size(x))*kl(2,:))*diag(1./(sqrt(kl(1,:).^2 + ones(size(kl(1,:))))));
ytotalDiff = @(x, y, abc) abs(y*abc(2,:) +x*abc(1,:) + ones(size(x))*abc(3,:))*diag(1./(sqrt(abc(1,:).^2 + abc(2,:).^2)));
y1totalDiff = ytotalDiff(x, y, [kl1(1);-1;kl1(2)]);
sq = @(y) sqrt(sum(y.^2));
y1Dists = [sq(y1diff), sq(y1totalDiff)];

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
%y2totalDiff = ytotalDiff(x, y, [ab(1,:); c]*diag(1./ab(2,:)));
y2totalDiff = ytotalDiff(x, y, [ab; c]);
y2totalDist = sq(y2totalDiff);
[y2totalDist,abInd] = min(y2totalDist);
ac = -[ab(1,abInd); c(abInd)]./ab(2,abInd);
y2vals = ac(1)*x + ac(2);
y2diff = abs(y2vals-y);
y2Dists = [sq(y2diff), y2totalDist];



plot(x, y1vals, 'b');
hold on;
plot(x, y2vals, 'r');
plot(x,y,'x');
legend('Lsq', 'totalLsq');

dists = [y1Dists; y2Dists];

