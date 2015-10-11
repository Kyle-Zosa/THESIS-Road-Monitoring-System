function vehicleDetection()
	loadParameters();
	loadVideoReaders();
	loadClassifiers();
	
	while ~(isDone(andrewVideoReader) || isDone(gokongweiVideoReader) || isDone(northVideoReader))
		[andrewDetections, gokongweiDetections, northDetections] = detect();
		[andrewValid, gokongweiValid, northValid] = validateDetections();
		classifyVehicles();
		featureExtraction();
		
		
	end
	
	function loadParameters()
		costOfNonAssignment = 20;
		ageThreshold = 8;
		invisibleCountThreshold = 20;
		visibilityThreshold = 0.6;
		kConfig = struct(...
			'MotionModel', 'ConstantVelocity', ...
			'Error', [200 50], ...
			'MotionNoise', [100 25], ...
			'MeasurementNoise', 100 ...
			);
	end
	function loadVideoReaders()
	end
	function loadClassifiers()
	
	function detect()
		
	end
	function validateDetections()
	end
	function
end