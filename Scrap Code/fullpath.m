function [fullPathString] = fullpath(pathfolder, filename, varargin)
%FULLPATH returns a concatenation of the input arguements.
%
%   fullpath(pathfolder, filename)
%   fullpath(pathfolder, filename, versionfolder)
%
%   Input arguement 'pathfolder' is to be a string variable coming from
%   PPaths of addProjectPaths.m
%   Valid arguements for 'versionfolder' are 'V1', 'V2', 'V3' and so on...
%   The arguement for 'filename' is the name of the file to be accessed.
	if pathfolder(end) ~= '\'
		pathfolder = strcat(pathfolder,'\');
	end
    if nargin == 2
        fullPathString = strcat(pathfolder, filename);
    else
        fullPathString = strcat(pathfolder, varargin{1}, '\', filename);
    end
end

