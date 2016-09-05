clear;
load('assignment1bases.mat')
for basenbr = 1:3
    figure(1);
    subplot(2,2,1);
    for ev = 1:4
        ei = bases{basenbr}(:,:,ev);
        subplot(2,2,ev)
        image(ei);
        imagesc(ei);
        colormap(gray);
        pause;
    end 
end