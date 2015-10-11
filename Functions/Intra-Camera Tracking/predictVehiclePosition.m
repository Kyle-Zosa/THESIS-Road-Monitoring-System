function [vehicleTracks] = predictVehiclePosition(vehicleTracks)
	for i = 1:length(vehicleTracks)
		bbox = vehicleTracks(i).bbox;
		centroid = predict(vehicleTracks(i).kalman);
		centroid = round(centroid - double(bbox(3:4) / 2));
		vehicleTracks(i).bbox = [centroid, bbox(3:4)];
	end
end