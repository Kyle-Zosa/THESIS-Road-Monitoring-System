function [detectionTracks, validatedTracks] = updateDetectionTracks(detectionTracks, centroids, bboxes, assignments, validVisibleAge)
	assignmentsLength = size(assignments, 1);
	for i = 1:assignmentsLength
		trackId = assignments(i, 1);
		detectionId = assignments(i, 2);
		
		centroid = centroids(detectionId, :);
		bbox = bboxes(detectionId, :);
		
		correct(detectionTracks(trackId).kalman, centroid);
		detectionTracks(trackId).bbox = bbox;
		detectionTracks(trackId).age = detectionTracks(trackId).age + 1;
		detectionTracks(trackId).visibleCount = detectionTracks(trackId).visibleCount + 1;
		detectionTracks(trackId).invisibleCount = 0;

		validated = [detectionTracks.visibleCount] >= validVisibleAge;
		validatedTracks = detectionTracks(validated);
	end
end