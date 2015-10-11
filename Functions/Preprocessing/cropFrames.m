function [aFrame, gFrame, nFrame] = cropFrames(aFrame, gFrame, nFrame, cropBox)
	aFrame = imcrop(aFrame, cropBox);
	gFrame = imcrop(gFrame, cropBox);
	nFrame = imcrop(nFrame, cropBox);
end