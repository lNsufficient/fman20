function y = features2class(x,data)
classVector = zeros(26,1);
scoreVector = zeros(26,1);
    for i = 1:26
        [c, s] = predict(data{i}, double(x)');
        s = s(2);
        classVector(i) = c;
        scoreVector(i) = s;
    end
    maxProb = max(scoreVector);
    y1 = find(scoreVector == maxProb);
    scoreVector = scoreVector(y1);
    [y2, s] = predict(data{end}, double(x)');
    scoreVector = [scoreVector; s(y2)];
    if (isempty(y1))
        disp('check this out, somethings bad.')
        y = y2;
    else
        ys = [y1; y2];
        [~, i] = max(scoreVector);
        y = ys(i);
        if (y ~= y2)
            disp('Klassifieras inte enligt fitcknn')
        end
    end
end