function outputTrack(file, location, time, class, vehicleType, len, width, id)
	fprintf(file, '%s\t%.2f\t%s\t%s\t%.4f\t%.4f\t%d\n', location, time, class, vehicleType, len, width, id);
end