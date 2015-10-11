function [detectionTracks] = deleteLostTracks(detectionTracks, ageThreshold, visibilityThreshold, invisibleCountThreshold, validVisibleAge)
	if isempty(detectionTracks)
		return;
	else
		ages = [detectionTracks.age];
		visibleCounts = [detectionTracks.visibleCount];
		invisibleCounts = [detectionTracks.invisibleCount];
		visibility = visibleCounts./ages;
		
		lostTracks = (ages < ageThreshold & visibility < 0.6) | (invisibleCounts >= invisibleCountThreshold);
		detectionTracks = detectionTracks(~lostTracks);

		validated = [detectionTracks.age] >= validVisibleAge;
		detectionTracks = detectionTracks(~validated);
	end
end