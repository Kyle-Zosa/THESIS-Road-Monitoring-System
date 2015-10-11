frameCount = 1;
fps = 6;
time = frameCount/fps;

resizeFactor = 3/4;

nextId = 1;
visibilityThreshold = 0.6;
ageThreshold = 8;
invisibleCountThreshold = 10;
costOfNonAssignment = 20;

kConfig = struct(...
			'MotionModel', 'ConstantVelocity', ...
			'Error', [10 10], ...
			'MotionNoise', [25 10], ...
			'MeasurementNoise', 10 ...
			);

aLoc = 'AND';
gLoc = 'GOK';
nLoc = 'NOR';

aCount = -1;
gCount = -1;
nCount = -1;