function [aMaskedFrame, gMaskedFrame, nMaskedFrame] = polyMaskFrames(aFrame, gFrame, nFrame, aMask, gMask, nMask)
	aMaskedFrame = aFrame .* aMask;
	gMaskedFrame = gFrame .* gMask;
	nMaskedFrame = nFrame .* nMask;
end