loadROI;

aPolyMask = roipoly(croppedDim(1), croppedDim(2), aROI.x, aROI.y);
gPolyMask = roipoly(croppedDim(1), croppedDim(2), gROI.x, gROI.y);
nPolyMask = roipoly(croppedDim(1), croppedDim(2), nROI.x, nROI.y);

aPolyMask = imresize(aPolyMask, resizeFactor);
gPolyMask = imresize(gPolyMask, resizeFactor);
nPolyMask = imresize(nPolyMask, resizeFactor);

aPolyMask = repmat(aPolyMask,[1 1 3]);
gPolyMask = repmat(gPolyMask,[1 1 3]);
nPolyMask = repmat(nPolyMask,[1 1 3]);

aROI.Box = aROI.Box .* resizeFactor;
gROI.Box = gROI.Box .* resizeFactor;
nROI.Box = nROI.Box .* resizeFactor;