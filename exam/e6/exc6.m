clear;
load('tentadata2016okt.mat')

I = im;

normEd = @(u) sqrt(sum(sum(conj(u).*u)));

x = 141;
y = 22;
s = 6;
I_small = I(x-s:x+s, y-s:y+s);
I_small_norm = normEd(I_small);
strI_small = sprintf('u, norm: %f', I_small_norm);

figure(1)
image(I)
imagesc(I);
%colormap('gray')

figure(2)
image(I_small);
imagesc(I_small);
%colormap('gray')

[up6, up6n, up6x, ~] = projectOnBasis(I_small,basis1to6);
[up7, up7n, up7x, ~] = projectOnBasis(I_small,basis7);

figure(3)
for i = 1:6
    subplot(2,4,i)
    imagesc(basis1to6(:,:,i))
    str = sprintf('basis%d',i);
    title(str)
end
subplot(2,4,7)
imagesc(I_small);
title(strI_small)

subplot(2,4,8)
image(up6)
%imagesc(I_small)
imagesc(up6, [min(min(I_small)), max(max(I_small))]);
str = sprintf('up6, norm: %f', up6n);
title(str);

figure(4)
subplot(2, 2, 1)
imagesc(basis7);
title('basis7');

subplot(2,2,2)
imagesc(I_small);
title(strI_small);

subplot(2,2,3)
imagesc(up7, [min(min(I_small)), max(max(I_small))]);
%det funkade inte bra att använda samma imagescale på up7 som I_small.
%Då I_small projicerades på basis7 fick den mycket mindre max- och
%min-intensitet. 
imagesc(up7) %Denna ser ut som basis7, eftersom den endast består av basis7 
%multiplicerat med en skalär. 
str = sprintf('up7, norm: %f', up7n);
title(str);

subplot(2,2,4)
up67 = up6+up7;
imagesc(up67, [min(min(I_small)), max(max(I_small))]);
%Genom att använda samma imagesc som på I_small kan jag se om färgerna
%matchar
up67n = sqrt(up6n^2+up7n^2);
str = sprintf('up7+up6, norm: %f', up67n);
title(str)

TOL = 1e-12;
%Testing norms
up67n2 = normEd(up67);
if abs(up67n2 - up67n) > TOL
    disp('up67n wrong')
end

if abs(up6n - normEd(up6)) > TOL
    disp('up6n wrong')
end

if abs(up7n ~= normEd(up7)) > TOL
    disp('up7n wrong')
end

%calculate |u3|:
%Eftersom vi har 169 basvektorer och dimensionen av u är 169 så kommer vi
%kunna avbilda u perfekt med hjälp av samtliga basvektorer (förutsatt att
%de är ortogonala vilket de är enligt uppgiften). 
% Detta ger oss två sätt att beräkna u:
u3 = I_small - up7 - up6; %här är approachen att först beräkna vad u3 är 
%för att sedan beräkna dess norm:
u3n = normEd(u3);
%här är approachen att |u1+u2+u3| = sqrt(|u1|^2+|u2|^2+|u3|^2) = |u|
u3n2 = sqrt(I_small_norm^2 - up6n^2 - up7n^2);
%Båda gav samma resultat: 36.0453

u1n = up6n
u2n = up7n
u3n

figure(5)
subplot(3,2,1)
imagesc(I_small)
title(strI_small)

subplot(3,2,2)
imagesc(u3+up6+up7)
title('summan av u1, u2, u3')

subplot(3,2,3)
imagesc(up6)
str = sprintf('u1, norm: %f', u1n)
title(str)

subplot(3,2,4)
imagesc(up7)
str = sprintf('u2, norm: %f', u2n)
title(str)

subplot(3,2,5)
imagesc(u3)
str = sprintf('u3, norm: %f', u3n)
title(str)


%%
%beräkning av |u|
II = conj(I).*I;
patch = ones(13,13);
U = sqrt(conv2(II,patch,'same'));

[m, n] = size(I);
Xi = zeros(m, n, 6);
for i=1:6
    patch = basis1to6(:,:,i);
    patch = flipud(fliplr(patch));
    Xi(:,:,i) = conv2(conj(I),patch,'same');
end
U1 = sqrt(sum(Xi.^2,3));

patch = basis7;
patch = flipud(fliplr(patch));
U2 = conv2(conj(I),patch,'same');
U2 = abs(U2)

U3 = sqrt(sum(U.^2-U1.^2-U2.^2,3));

ud3 = U3 < 48;
ud2 = U2 > 60;
ud = ud2.*ud3;
[dot_m, dot_n] = find(ud == 1);

figure(6)
subplot(3,2,1)
imagesc(I);
title('im')

subplot(3, 2, 2)
imagesc(U);
title('|u|')

subplot(3, 2, 3)
imagesc(U1);
title('|u1|')

subplot(3, 2, 4)
imagesc(U2);
colormap('gray')
title('|u2|')

subplot(3, 2, 5)
imagesc(U3);
title('|u3|')

subplot(3,2,6)
imagesc(ud);
title('center of dots')
