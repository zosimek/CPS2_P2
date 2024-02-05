function [cnt_file_names, cnt_file_count] = load_cnt_from_dir(path)

    % OUTPUT:
    %   – cnt_file_names [list[string]]: .cnt file names (in the path directory)
    %   – cnt_file_count [integer]: the number of .cnt files in the directory
    %
    % INPUT:
    %   – path [string]: the path to the directory that stores .cnt files

    
    % Get a list of all files in the directory
    all_files = dir(fullfile(path, '*.cnt'));
    
    % Count the number of .cnt files
    cnt_file_count = length(all_files);
    
    % Get the names of all .cnt files
    cnt_file_names = {all_files.name}';
    
    %%%%%%%%%%%% check %%%%%%%%%%%%%
    % Display the count
    %disp(['Number of .cnt files: ' num2str(numCntFiles)]);
    
    % Display the names of all .cnt files
    %disp('List of .cnt files:');
    %disp(cnt_file_names);