function [prevCount] = outputCount(file, time, count, prevCount)
	if count ~= prevCount
		fprintf(file, '%.2f\t%d\n', time, count);
	end
	prevCount = count;
end