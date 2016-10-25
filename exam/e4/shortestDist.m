function k_closest = shortestDist(x,X,k)
%SHORTESTDIST finds the k closest points in X to x

dists = dist(x, X);
[~, i] = sort(dists);
k_closest = i(1:k);
end

