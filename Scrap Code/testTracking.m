includeFunctions;

initializeParameters;
initializePolyMasks;

while ~isDone(aReader)
    aFrame = step(aReader);
    aFrame = imcrop(aFrame, cropBox);
    aFrame = imresize(aFrame, resizeFactor);
    
    mask = aFrame .* gPolyMask;
    [centroids, bboxes] = haarDetector(detector, mask, gROI.Box .* resizeFactor);
    % bboxes = step(vehicleDetector, frame);
    % xCenter = bboxes(:,1) + bboxes(:,3)/2;
    % yCenter = bboxes(:,2) + bboxes(:,4)/2;
    % centroids = int32(round([xCenter yCenter]));
    
    % mask = fgDetector.step(frame);
    % mask = imopen(mask, strel('rectangle', [3,3]));
    % mask = imclose(mask, strel('rectangle', [15, 15]));
    % mask = imfill(mask, 'holes');
    
    % [~, centroids, bboxes] = blobAnalyser.step(mask);
    
    aTracks = predictVehiclePosition(aTracks);

    [assignments, unassignedTracks, unassignedDetections] = trackAssignment(aTracks, centroids, costOfNonAssignment);

    aTracks = updateVehicleTracks(aTracks, centroids, bboxes, aFrame, assignments);
    aTracks = updateUnassignedTracks(aTracks, unassignedTracks);

    [aTracks, aToGTracks] = deleteLostTracks(aTracks, aToGTracks, ageThreshold, visibilityThreshold, invisibleCountThreshold);

    [aTracks, nextId] = createNewVehicleTracks(aTracks, nextId, unassignedDetections, aFrame, centroids, bboxes, kConfig);
    
    displayFrames;
end