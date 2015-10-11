function [vehicleTracks] = initializeVehicleTracks()
	vehicleTracks = struct(...
		'id', {}, ...
		'bbox', {}, ...
		'kalman', {}, ...
		'age', {}, ...
		'image', {}, ...
		'visibleCount', {}, ...
		'invisibleCount', {}, ...
		'features', {}, ...
		'class', {} ...
		);
end

function [vehicleTracks] = predictVehiclePosition(vehicleTracks)
	for i = 1:length(vehicleTracks)
		bbox = vehicleTracks(i).bbox;
		centroid = predict(vehicleTracks(i).kalman);
		centroid = int32(centroid) - bbox(3:4) / 2;
		vehicleTracks(i).bbox = [centroid, bbox(3:4)];
	end
end

function [assignments, unassignedTracks, unassignedDetections] = trackAssignment(vehicleTracks, centroids, costOfNonAssignment)
	trackLength = length(vehicleTracks);
	detectionLength = size(centroids, 1);
	
	costMatrix = zeros(trackLength, detectionLength);
	
	for i = 1:trackLength
		costMatrix(i, :) = distance(vehicleTracks(i).kalman, centroids);
	end
	
	[assignments, unassignedTracks, unassignedDetections] = assignDetectionsToTracks(costMatrix, costOfNonAssignment);
end

function [vehicleTracks] = updateVehicleTracks(vehicleTracks, centroids, bboxes, assignments)
	assignmentsLength = size(assignments, 1);
	for i = 1:assignmentsLength
		trackId = assignments(i, 1);
		detectionId = assignments, 2);
		
		centroid = centroids(detectionId, :);
		bbox = bboxes(detectionId, :);
		
		correct(vehicleTracks(trackId).kalman, centroid);
		vehicleTracks(trackId).bbox = bbox;
		vehicleTracks(trackId).age = vehicleTracks(trackId).age + 1;
		vehicleTracks(trackId).visibleCount = vehicleTracks(trackId).visibleCount + 1;
		vehicleTracks(trackId).invisibleCount = 0;
	end
end

function [vehicleTracks] = updateUnassignedTracks(vehicleTracks, unassignedTracks)
	for i = 1:length(unassignedTracks)
		trackId = unassignedTracks(i);
		vehicleTracks(trackId).age = vehicleTracks(trackId).age + 1;
		vehicleTracks(trackId).invisibleCount = vehicleTracks(trackId).invisibleCount + 1;
	end
end

function [vehicleTracks] = deleteLostTracks(vehicleTracks, ageThreshold, visibilityThreshold, invisibleCountThreshold)
	if isempty(vehicleTracks)
		return;
	else
		ages = vehicleTracks.age;
		visibleCounts = vehicleTracks.visibleCount;
		invisibleCounts = vehicleTracks.invisibleCount;
		visibility = visibleCounts./ages;
		
		lostTracks = (ages < ageThreshold & visibility < 0.6) | (invisibleCounts >= invisibleCountThreshold);
		vehicleTracks = vehicleTracks(~lostTracks);
	end
end

function [vehicleTracks, nextId] = createNewVehicleTracks(vehicleTracks, nextId, unassignedDetections, frame, centroids, bboxes, kConfig)
	centroids = centroids(unassignedDetections, :);
	bboxes = bboxes(unassignedDetections, :);
	
	for i = 1:size(centroids, 1)
		centroid = centroids(i, :);
		bbox = bboxes(i, :);
		
		kalman = configureKalmanFilter(...
			kConfig.MotionModel, ...
			centroid, ...
			kConfig.Error, ...
			kConfig.MotionNoise, ...
			kConfig.MeasurementNoise ...
			);
		
		image = imcrop(frame, bbox);
		features = {};
		class = {};
		
		vehicleTrack = struct(...
			'id', 	nextId, ...
			'bbox', bbox, ...
			'kalman', kalman, ...
			'age', 1, ...
			'image', image, ...
			'visibleCount', 1, ...
			'invisibleCount', 0, ...
			'features', features ...
			'class', class ...
			);
		
		vehicleTracks(end + 1) = vehicleTrack;
		nextId = nextId + 1;
	end
end