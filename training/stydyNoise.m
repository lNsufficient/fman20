N =600;
choice = 12;

if choice == 1
    I = rand(N, N);
elseif choice == 2
    midSquare = [100, 100; 200, 200];
    I = zeros(N,N);
    [x, y] = ndgrid(midSquare(1,1):midSquare(2,1), midSquare(1,2):midSquare(2,2));
    I(x, y) = 1;
elseif choice == 3
    I = randn(N,N);
elseif choice == 4
    I = ones(N,N);
elseif choice == 5
    I = ones(N,N);
    mid = [1, N/2; N, N]
    [x,y] = ndgrid(mid(1,1):mid(2,1), mid(1,2):mid(2,2));
    I(x,y) = -1;
elseif choice == 6
    N = 551;
    I = ones(N,N);
    I(2:2:N*N) = 0;
elseif choice == 7
    N = 100;
    b = 100;
    mid = round(N/2);
    [x, y] = ndgrid((1:N)-mid, (1:N)-mid);
    I = 1/(2*pi*b.^2)*exp(-(x.^2+y.^2)/(2*b.^2));
elseif choice == 8
    I = imread('fourier_ex.jpg');
elseif choice == 9
    I = eye(N);
elseif choice == 10
    I = imread('ex.gif');
elseif choice == 11
    I = imread('ex.gif');
    I = fftshift(I);
    I = fft2(I);
    I = fftshift(I);
elseif choice == 12
    I = imread('zebra.jpg');
    I = rgb2gray(I);

end

Ifour = fft2(I);
Ifour = fftshift(Ifour);
Ifour = fourierIm(Ifour);
plotBoth(I, Ifour)