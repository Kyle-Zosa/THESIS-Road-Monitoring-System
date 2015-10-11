function [detectionTracks] = predictDetectionPosition(detectionTracks)
	for i = 1:length(detectionTracks)
		bbox = detectionTracks(i).bbox;
		centroid = predict(detectionTracks(i).kalman);
		centroid = int32(centroid) - bbox(3:4) / 2;
		detectionTracks(i).bbox = [centroid, bbox(3:4)];
	end
end