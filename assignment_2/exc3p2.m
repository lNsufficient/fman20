
m = [0.4, 0.3, 0.5];
sigma  = [0.01, 0.05, 0.2];
% unknowns = [0.4003, 0.3988, 0.3998, 0.3997, 0.401, 0.3395, 0.3991; 
%             0.2554, 0.3139, 0.2627, 0.3802, 0.3287, 0.3160, 0.2924;
%             0.5632, 0.7687, 0.0524, 0.7586, 0.4243, 0.5005, 0.6769];
unknowns = [0.4003, 0.3988, 0.3998, 0.3997, 0.401, 0.3995, 0.3991; 
            0.2554, 0.3139, 0.2627, 0.3802, 0.3287, 0.3160, 0.2924;
            0.5632, 0.7687, 0.0524, 0.7586, 0.4243, 0.5005, 0.6769];
classProbabilities = [1/3, 1/3, 1/3]';   
nbr = numel(unknowns);

probableClass = zeros(size(unknowns));
Px = zeros(size(unknowns));
for i = 1:nbr
    
    pyx = normpdf(unknowns(i), m, sigma);
    py = pyx*classProbabilities;
    probs = pyx.*classProbabilities'/py;
    [val, j] = max(probs);
    
    probableClass(i) = j;
    Px(i) = val;
end

latex_table = latex(sym(probableClass));
file = fopen('probableClass.tex','w');
fprintf(file,'%s',latex_table);
fclose(file);

latex_table = latex(sym(Px,'d'));
file = fopen('Px.tex','w');
fprintf(file,'%s',latex_table);
fclose(file);