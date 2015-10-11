function [vehicleTracks] = updateVehicleTracks(vehicleTracks, centroids, bboxes, frame, assignments)
	assignmentsLength = size(assignments, 1);
	for i = 1:assignmentsLength
		trackId = assignments(i, 1);
		detectionId = assignments(i, 2);
		
		centroid = centroids(detectionId, :);
		bbox = bboxes(detectionId, :);
		image = imcrop(frame, bbox);
		features = extractColorFeatures(image);

		correct(vehicleTracks(trackId).kalman, centroid);
		vehicleTracks(trackId).bbox = bbox;
		vehicleTracks(trackId).image = image;
		vehicleTracks(trackId).age = vehicleTracks(trackId).age + 1;
		vehicleTracks(trackId).visibleCount = vehicleTracks(trackId).visibleCount + 1;
		vehicleTracks(trackId).invisibleCount = 0;

		%% RESEARCH BETTER MEANS OF TRACKING
		% vehicleTracks(trackId).features(vehicleTracks(trackId).visibleCount, :) = features;

		% figure(vehicleTracks(trackId).id); imshow(image);
	end
end