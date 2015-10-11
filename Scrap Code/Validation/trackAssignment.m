function [assignments, unassignedTracks, unassignedDetections] = trackAssignment(detectionTracks, centroids, costOfNonAssignment)
	trackLength = length(detectionTracks);
	detectionLength = size(centroids, 1);
	
	costMatrix = zeros(trackLength, detectionLength);
	
	for i = 1:trackLength
		costMatrix(i, :) = distance(detectionTracks(i).kalman, centroids);
	end
	
	[assignments, unassignedTracks, unassignedDetections] = assignDetectionsToTracks(costMatrix, costOfNonAssignment);
end