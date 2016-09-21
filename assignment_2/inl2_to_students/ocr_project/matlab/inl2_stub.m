datadir = '../datasets/short1';

a = dir(datadir);

file = 'im9';

fnamebild = [datadir filesep file '.jpg'];
fnamefacit = [datadir filesep file '.txt'];

bild = imread(fnamebild);
image(bild)
imagesc(bild)
colormap('gray')
fid = fopen(fnamefacit);
facit = fgetl(fid);
fclose(fid);

S = im2segment(bild);
B = S{1};
x = segment2features(B);

figure(1);
image(B);
imagesc(B);
colormap('gray');
x