includeFunctions;

videoPath = 'G:\Thesis\Videos\Sept 7';
videoName = '0600-0800.mpg';
[~, videoDate] = fileparts(videoPath);

createSystemObjects;

initializeTracks;
initializeParameters;
initializeROIs;

openRecordFiles;

while ~(isDone(aReader) || isDone(gReader) || isDone(nReader))

    [aFrame, gFrame, nFrame] = getFrames(aReader, gReader, nReader);
    [aFrame, gFrame, nFrame] = cropFrames(aFrame, gFrame, nFrame, cropBox);
    [aFrame, gFrame, nFrame] = resizeFrames(aFrame, gFrame, nFrame, resizeFactor);
    
%     aFrame = rgb2hsv(aFrame);
%     gFrame = rgb2hsv(gFrame);
%     nFrame = rgb2hsv(nFrame);
%     aFrame(:,:,3) = histeq(aFrame(:,:,3));
%     gFrame(:,:,3) = histeq(gFrame(:,:,3));
%     nFrame(:,:,3) = histeq(nFrame(:,:,3));
%     aFrame = hsv2rgb(aFrame);
%     gFrame = hsv2rgb(gFrame);
%     nFrame = hsv2rgb(nFrame);
    
    
    [aMasked, gMasked, nMasked] = polyMaskFrames(aFrame, gFrame, nFrame, aPolyMask, gPolyMask, nPolyMask);

    [aCentroids, aBBoxes] = haarDetector(detector, aMasked, aROI.Box);
    [gCentroids, gBBoxes] = haarDetector(detector, gMasked, gROI.Box);
    [nCentroids, nBBoxes] = haarDetector(detector, nMasked, nROI.Box);
    
    %% ANDREW TRACKS
    aTracks = predictVehiclePosition(aTracks);

    [aAssignments, aUnassignedTracks, aUnassignedDetections] = trackAssignment(aTracks, aCentroids, costOfNonAssignment);

    aTracks = updateVehicleTracks(aTracks, aCentroids, aBBoxes, aFrame, aAssignments);
    aTracks = updateUnassignedTracks(aTracks, aUnassignedTracks);

    [aTracks, aToGTracks] = deleteLostTracks(...
        aTracks, aToGTracks, ...
        ageThreshold, visibilityThreshold, ...
        invisibleCountThreshold, ...
        aLoc, time, outputHandler ...
        );

    [aTracks, nextId] = createNewVehicleTracks(...
        aTracks, vehicleClassifier, ...
        nextId, aUnassignedDetections, ...
        aFrame, aCentroids, ...
        aBBoxes, kConfig, ...
        aLoc, time, outputHandler ...
        );
    %% ANDREW TRACKS

    %% GOKONGWEI TRACKS
    gTracks = predictVehiclePosition(gTracks);

    [gAssignments, gUnassignedTracks, gUnassignedDetections] = trackAssignment(gTracks, gCentroids, costOfNonAssignment);

    gTracks = updateVehicleTracks(gTracks, gCentroids, gBBoxes, gFrame, gAssignments);
    gTracks = updateUnassignedTracks(gTracks, gUnassignedTracks);

    [gTracks, gToNTracks] = deleteLostTracks(...
        gTracks, gToNTracks, ...
        ageThreshold, visibilityThreshold, ...
        invisibleCountThreshold, ...
        gLoc, time, outputHandler ...
        );

    [gTracks, nextId, aToGTracks] = createNMatchVehicleTracks(...
        gTracks, vehicleClassifier, aToGTracks, ...
        nextId, gUnassignedDetections, ...
        gFrame, gCentroids, ...
        gBBoxes, kConfig, ...
        gLoc, time, outputHandler ...
        );
    %% GOKONGWEI TRACKS

    %% NORTH TRACKS
    nTracks = predictVehiclePosition(nTracks);

    [nAssignments, nUnassignedTracks, nUnassignedDetections] = trackAssignment(nTracks, nCentroids, costOfNonAssignment);

    nTracks = updateVehicleTracks(nTracks, nCentroids, nBBoxes, nFrame, nAssignments);
    nTracks = updateUnassignedTracks(nTracks, nUnassignedTracks);

    [nTracks, ~] = deleteLostTracks(...
        nTracks, {}, ...
        ageThreshold, visibilityThreshold, ...
        invisibleCountThreshold, ...
        nLoc, time, outputHandler ...
        );

    [nTracks, nextId, gToNTracks] = createNMatchVehicleTracks(...
        nTracks, vehicleClassifier, gToNTracks, ...
        nextId, nUnassignedDetections, ...
        nFrame, nCentroids, ...
        nBBoxes, kConfig, ...
        nLoc, time, outputHandler ...
        );
    %% NORTH TRACKS

%     displayFrames;

    aCount = outputCount(outputHandler.aCount, time, size(aBBoxes,1), aCount);
    gCount = outputCount(outputHandler.gCount, time, size(gBBoxes,1), gCount);
    nCount = outputCount(outputHandler.nCount, time, size(nBBoxes,1), nCount);

    frameCount = frameCount + 1;
    time = frameCount/fps;
%     w = waitforbuttonpress;
end

closeRecordFiles;