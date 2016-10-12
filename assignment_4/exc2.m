load('heart_data.mat')
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