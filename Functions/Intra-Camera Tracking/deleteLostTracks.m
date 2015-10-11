function [vehicleTracks, deletedTracks] = deleteLostTracks(vehicleTracks, deletedTracks, ageThreshold, visibilityThreshold, invisibleCountThreshold, location, time, outputHandler)
	if isempty(vehicleTracks)
		return;
	else
		ages = [vehicleTracks.age];
		visibleCounts = [vehicleTracks.visibleCount];
		invisibleCounts = [vehicleTracks.invisibleCount];
		visibility = visibleCounts./ages;
		
		lostTracks = (ages < ageThreshold & visibility < 0.6) | (invisibleCounts >= invisibleCountThreshold);
		newDeletedTracks = vehicleTracks(lostTracks);

		for i = 1:length(newDeletedTracks)
			class = newDeletedTracks(i).class;
			vehicleType = newDeletedTracks(i).type;
			len = newDeletedTracks(i).dimensions(1);
			width = newDeletedTracks(i).dimensions(1);
			id = newDeletedTracks(i).id;

			outputTrack2(outputHandler.track2, location, time, class, vehicleType, len, width, id, 'EXIT');
			%% REMOVE FOR FINAL VERSION
			% id = newDeletedTracks(i).id;
			% features = newDeletedTracks(i).features;
			% xPlot = 0:size(features,1)-1;
			% figure(id);
			% subplot(2,3,1); plot(xPlot, features(:,1),'-*'); axis([0 size(features,1) 0 1]);
			% subplot(2,3,2); plot(xPlot, features(:,2),'-*'); axis([0 size(features,1) 0 1]);
			% subplot(2,3,3); plot(xPlot, features(:,3),'-*'); axis([0 size(features,1) 0 1]);
			% subplot(2,3,4); plot(xPlot, features(:,4),'-*'); axis([0 size(features,1) 0 1]);
			% subplot(2,3,5); plot(xPlot, features(:,5),'-*'); axis([0 size(features,1) 0 1]);
			% subplot(2,3,6); plot(xPlot, features(:,6),'-*'); axis([0 size(features,1) 0 1]);
			% getCentroids(newDeletedTracks(i).bbox);
			%% REMOVE FOR FINAL VERSION
		end

		deletedTracks = [deletedTracks newDeletedTracks];
		vehicleTracks = vehicleTracks(~lostTracks);
	end
end