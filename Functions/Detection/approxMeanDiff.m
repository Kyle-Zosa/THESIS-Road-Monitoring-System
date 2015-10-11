function [mask, centroids, bboxes, background] = approxMeanDiff(currentFrame, background, bufferSize, threshold)
	mask = (currentFrame - background) > threshold;
	
end