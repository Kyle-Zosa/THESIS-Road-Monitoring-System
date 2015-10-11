functionsDirectory = dir('Functions');
functionsDirectory = functionsDirectory(3:end);
functionPaths = functionsDirectory([functionsDirectory.isdir]');
functionPaths = cell2struct(strcat('Functions\', {functionPaths.name}'), 'name', length(functionPaths));

addpath(functionPaths.name);
addpath('Functions');
addpath('Resources');