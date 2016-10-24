load('heart_data.mat')
addpath(genpath('maxflow'))
[M N] = size(im);
n = M*N;%Number of image pixels
[mu0hat, sigma0hat] = normfit(background_values);
[mu1hat, sigma1hat] = normfit(chamber_values);

backround_toprow_chamber_bottomrow = [mu0hat, sigma0hat; mu1hat, sigma1hat]

%Dessa är sannolikheterna för en viss intensitet givet en viss klass,
%alltså P(f(x,y)|classX). Dessa svarar alltså mot vikterna från s till i,
%respektive i till t. 
background_probabilities = normpdf(im, mu0hat, sigma0hat);
chamber_probabilities = normpdf(im, mu1hat, sigma1hat);

Neighbors = edges4connected(M, N);
i = Neighbors(:,1);
j = Neighbors(:,2);
nu = 7;
A = sparse(i, j, nu, n, n);
fine_tune = 1;
if fine_tune
    background_pixels = [(85:M)', N*(ones(size((85:M)'))); 80, 90; 90, 80; M*ones(size((70:N)')), (70:N)'];
    background_probabilities(background_pixels(:,1), background_pixels(:,2)) = inf;
    %background_probabilities(end,end) = inf;
end
%se till att T är i rätt ordning (utveckla utmed rader/kolumner?)
T = [-log(background_probabilities(:)) -log(chamber_probabilities(:))];
T = sparse(T);

[e, theta] = maxflow(A, T);
theta = reshape(theta, M, N);
theta = double(theta);

figure(1);
image(im);
imagesc(im);
colormap('gray')

figure(2);
image(theta);
imagesc(theta);
colormap('gray');

comb = theta.*im;

figure(3);
image(comb);
imagesc(comb);
colormap('gray')

comb_inv = im - comb;
figure(4);
image(comb_inv);
imagesc(comb_inv);
colormap('gray')