function [aFrame, gFrame, nFrame] = resizeFrames(aFrame, gFrame, nFrame, resizeFactor)
	aFrame = imresize(aFrame, resizeFactor);
	gFrame = imresize(gFrame, resizeFactor);
	nFrame = imresize(nFrame, resizeFactor);
end