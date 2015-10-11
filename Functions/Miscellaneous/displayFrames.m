aFrame = im2uint8(aFrame);
gFrame = im2uint8(gFrame);
nFrame = im2uint8(nFrame);

if ~isempty(aTracks)
    idList = [aTracks.id]';
    bboxDisplay = cat(1, cell2mat({aTracks.bbox}'));
    idLabel = cellstr(int2str(idList));
    labels = cell(size(idLabel));
    labels = {'ID:'};
    labels = strcat(labels, idLabel);
    
    aFrame = insertObjectAnnotation(aFrame, 'rectangle', bboxDisplay, labels);
end

if ~isempty(gTracks)
    idList = [gTracks.id]';
    bboxDisplay = cat(1, cell2mat({gTracks.bbox}'));
    idLabel = cellstr(int2str(idList));
    labels = cell(size(idLabel));
    labels = {'ID:'};
    labels = strcat(labels, idLabel);
    
    gFrame = insertObjectAnnotation(gFrame, 'rectangle', bboxDisplay, labels);
end

if ~isempty(nTracks)
    idList = [nTracks.id]';
    bboxDisplay = cat(1, cell2mat({nTracks.bbox}'));
    idLabel = cellstr(int2str(idList));
    labels = cell(size(idLabel));
    labels = {'ID:'};
    labels = strcat(labels, idLabel);
    
    nFrame = insertObjectAnnotation(nFrame, 'rectangle', bboxDisplay, labels);
end

aPlayer.step(aFrame);
gPlayer.step(gFrame);
nPlayer.step(nFrame);