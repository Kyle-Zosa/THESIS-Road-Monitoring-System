aPath = strcat(videoPath, '\Andrew\', videoName);
gPath = strcat(videoPath, '\Gokongwei\', videoName);
nPath = strcat(videoPath, '\North\', videoName);

aReader = vision.VideoFileReader(aPath);
gReader = vision.VideoFileReader(gPath);
nReader = vision.VideoFileReader(nPath);

aPlayer = vision.VideoPlayer('Name', 'Andrew');
gPlayer = vision.VideoPlayer('Name', 'Gokongwei');
nPlayer  = vision.VideoPlayer('Name', 'North');

detector = vision.CascadeObjectDetector('detector.xml', ...
    'MergeThreshold', 10, ...
    'UseROI', 1 ...
    );

load('vehicleClassifier.mat');