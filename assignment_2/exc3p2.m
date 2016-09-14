
m = [0.4, 0.3, 0.5];
sigma  = [0.01, 0.05, 0.2];
unknowns = [0.4003, 0.3988, 0.3998, 0.3997, 0.401, 0.3395, 0.3991; 
            0.2554, 0.3139, 0.2627, 0.3802, 0.3287, 0.3160, 0.2924;
            0.5632, 0.7687, 0.0524, 0.7586, 0.4243, 0.5005, 0.6769];
classProbabilites = [1/3, 1/3, 1/3];   
     
for i = numel(unknowns)
    
    propabilities = normpdf(unknowns(i), m, sigma);
    py = probabilities*classProbabilites;
    probabilites = 
end
        