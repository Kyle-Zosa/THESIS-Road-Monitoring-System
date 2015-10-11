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
			'Error', [100 100], ...
			'MotionNoise', [15 5], ...
			'MeasurementNoise', 15 ...
			);

aLoc = 'AND';
gLoc = 'GOK';
nLoc = 'NOR';

aCount = -1;
gCount = -1;
nCount = -1;