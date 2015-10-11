function outputFolder(folderpath)
%OUTPUTFOLDER returns a concatenation of the input arguements.
%
%   outputFolder(folderpath)
%
%   Creates a folder with path 'folderpath' if folder does not exist
	if ~exist(folderpath, 'dir')
		mkdir(folderpath);
	end
end

