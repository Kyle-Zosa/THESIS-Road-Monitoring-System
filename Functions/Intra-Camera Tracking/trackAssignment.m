function [assignments, unassignedTracks, unassignedDetections] = trackAssignment(vehicleTracks, centroids, costOfNonAssignment)
	trackLength = length(vehicleTracks);
	detectionLength = size(centroids, 1);
	
	costMatrix = zeros(trackLength, detectionLength);
	
	for i = 1:trackLength
		costMatrix(i, :) = distance(vehicleTracks(i).kalman, centroids);
	end
	
	[assignments, unassignedTracks, unassignedDetections] = assignDetectionsToTracks(costMatrix, costOfNonAssignment);
end