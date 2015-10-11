function [centroids] = getCentroids(bboxes)
	x = bboxes(:,1) + bboxes(:,3)./2;
	y = bboxes(:,2) + bboxes(:,4)./2;
    centroids = [x y];
end