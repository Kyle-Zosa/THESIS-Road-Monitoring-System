function [mask, centroids, bboxes] = frameDifference(currentFrame, previousFrame, threshold)
	mask = abs(currentFrame - previousFrame) > threshold;
end