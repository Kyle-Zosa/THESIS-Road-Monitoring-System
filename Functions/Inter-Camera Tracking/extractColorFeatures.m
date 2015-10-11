function [colorFeatures] = extractColorFeatures(image)
	R = mean2(image(:,1));
	G = mean2(image(:,2));
	B = mean2(image(:,3));

	R_std = std2(image(:,1));
	G_std = std2(image(:,2));
	B_std = std2(image(:,3));

	colorFeatures = [R G B R_std G_std B_std];
end