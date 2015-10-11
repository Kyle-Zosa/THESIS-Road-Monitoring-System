function [detectionTracks] = updateUnassignedTracks(detectionTracks, unassignedTracks)
	for i = 1:length(unassignedTracks)
		trackId = unassignedTracks(i);
		detectionTracks(trackId).age = detectionTracks(trackId).age + 1;
		detectionTracks(trackId).invisibleCount = detectionTracks(trackId).invisibleCount + 1;
	end
end