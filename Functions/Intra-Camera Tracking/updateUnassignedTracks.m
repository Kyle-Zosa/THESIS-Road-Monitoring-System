function [vehicleTracks] = updateUnassignedTracks(vehicleTracks, unassignedTracks)
	for i = 1:length(unassignedTracks)
		trackId = unassignedTracks(i);
		vehicleTracks(trackId).age = vehicleTracks(trackId).age + 1;
		vehicleTracks(trackId).invisibleCount = vehicleTracks(trackId).invisibleCount + 1;
	end
end