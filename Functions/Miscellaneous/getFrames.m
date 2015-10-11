function [aFrame, gFrame, nFrame] = getFrames(aReader, gReader, nReader)
	aFrame = step(aReader);
	gFrame = step(gReader);
	nFrame = step(nReader);
end