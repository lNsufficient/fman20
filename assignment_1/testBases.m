clear;
load('assignment1bases.mat')
meanErrors = zeros(3,2);
figure();
figure();
for imageStack = 2:2
    for basenbr = 1:3
                e1 = bases{basenbr}(:,:,1);
                e2 = bases{basenbr}(:,:,2);
                e3 = bases{basenbr}(:,:,3);
                e4 = bases{basenbr}(:,:,4);

        errors = zeros(400,1);
        for i = 1:400;
            
            u = stacks{imageStack}(:,:,i);
            [up, r] = projectOnBasis(u, e1, e2, e3, e4);
            errors(i) = r;
            figure(1);
            
            colormap(gray);
            image(u);
            imagesc(u);
            figure(2);

            colormap(gray);
            image(up);
            imagesc(up);
            [imageStack, basenbr];
            pause;
           
        end
        meanErrors(basenbr, imageStack) = mean(errors);
    end
end