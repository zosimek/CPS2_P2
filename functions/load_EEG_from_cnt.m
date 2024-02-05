function [EEG, standard_event_mark, deviant_event_mark] = load_EEG_from_cnt(cnt_file_path, varargin)
    
    % OUTPUT:
    %   – EEG: EEG data in EEGLAB format
    %   – standard_event_mark [string]: the mark of standard event
    %   – deviant_event_mark [string]: the mark of deviant event
    %
    % INPUT:
    %   – cnt_file_path [string]: EEG data path
    %   – varargin
    %       1) standard_event_mark [string]: the mark of standard event
    %       2) deviant_event_mark [string]: the mark of deviant event

    % load needed packages
    addpath("eeglab\", "ANTeepimport1.13\", "functions\", "app\");

    % check the number of arguments provided
    narginchk(1, 3);

    % read the .cnt file
    EEG = pop_loadeep_v4(cnt_file_path);

    %%%%%%%%%%%%%%%%%%%%%%%%
    % the case if only the name of the file was provided 'cause there's 
    % a need to determine the standard- and deviant_event_mark
    if nargin == 1
        [standard_event_mark, deviant_event_mark] = find_event_marks(EEG);

    % if known and provided (the event marks) then
    % get the varargin arguments value
    elseif nargin == 3
        standard_event_mark = varargin{1};
        deviant_event_mark = varargin{2};
    else
        disp('incorrect number of arguments!')
    end