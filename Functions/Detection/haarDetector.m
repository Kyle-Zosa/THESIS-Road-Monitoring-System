function [centroids, bboxes] = haarDetector(detector, frame, detectorBBox)
	bboxes = step(detector, frame, detectorBBox);
	centroids = getCentroids(bboxes);
end