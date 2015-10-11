videoTime = videoName(1:end-4);
fileExtension = '.txt';

outputPath = ['Output\' videoDate];
countPath = [outputPath '\Count'];
trackPath = [outputPath '\Track'];

outputFolder(outputPath);
outputFolder(countPath);
outputFolder(trackPath);

trackFilepath = [trackPath '\Track - ' videoTime fileExtension];
track2Filepath = [trackPath '\Track(exit) - ' videoTime fileExtension];

aCountFilepath = [countPath '\Andrew Count - ' videoTime fileExtension];
gCountFilepath = [countPath '\Gokongwei Count - ' videoTime fileExtension];
nCountFilepath = [countPath '\North Count - ' videoTime fileExtension];

outputHandler = struct( ...
	'track', fopen(trackFilepath, 'wt'), ...
	'track2', fopen(track2Filepath, 'wt'), ...
	'aCount', fopen(aCountFilepath, 'wt'), ...
	'gCount', fopen(gCountFilepath, 'wt'), ...
	'nCount', fopen(nCountFilepath, 'wt') ...
	);

fprintf(outputHandler.track, 'Location\tTime\tClass\tType\tLength\tWidth\tID\n');
fprintf(outputHandler.track2, 'Location\tTime\tClass\tType\tLength\tWidth\tID\tStatus\n');
fprintf(outputHandler.aCount, 'Time\tCount\n');
fprintf(outputHandler.gCount, 'Time\tCount\n');
fprintf(outputHandler.nCount, 'Time\tCount\n');