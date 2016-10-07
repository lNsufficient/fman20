function y = features2class(x,data)
classVector = zeros(26,1);
    for(i = 1:26)
        classVector(i) = predict(data{i},x');
    end
    y = find(classVector==1,1);
    if (isempty(y))
        disp('check this out, somethings bad.')
        y = 1;
    end
end