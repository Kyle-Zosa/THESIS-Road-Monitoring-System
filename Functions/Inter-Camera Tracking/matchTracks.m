function [index] = matchTracks(trackArray, class, vehicleType, dimensions, features, matchThreshold)
	% score = strcmp({trackArray.class}', class) .* 0.25;
	% COMPARE FEATURES AND ADD TO SCORE
	% COMPARE DIMENSIONS AND ADD TO SCORE
	% index = find(score > matchThreshold);
    classMatchIndeces = strcmp({trackArray.class}', class);
    classMatchedTracks = trackArray(classMatchIndeces);

    index = [];
    score = zeros([length(classMatchedTracks) 1]);
    for i = 1:length(classMatchedTracks)
        featureScore = corr2(classMatchedTracks(i).features, features);
        dimensionsScore = 1 - (dimensions - classMatchedTracks(i).dimensions) ./ 100;
        score(i) = score(i) + (featureScore / 2) + (mean(dimensionsScore) / 2);
    end

    scorePass = score(score > matchThreshold);
    if ~isempty(scorePass)
	    index = find(score == max(scorePass));
	end
end