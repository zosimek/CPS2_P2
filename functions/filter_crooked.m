function EEG = filter_crooked(EEG, varargin)

    % OUTPUT:
    %   – EEG: filtered EEG data in EEGLAB format
    %
    % INPUT:
    %   – EEG [EEGLAB format]: EEG data
    %   – varargin
    %       filter type ['bandpass'|'highpass'|'lowpass']
    %       followed by it's filter file
    %
    %
    % Use example:
    %%% Define your filters (replace these with the actual .m files)
    %bandpassFilter = @bandpassFilterFunction;
    %highpassFilter = @highpassFilterFunction;
    %
    % Apply filters to EEG data
    %EEG = filter_raw_EEG(EEG, 'bandpass', bandpassFilter, 'highpass', highpassFilter);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % check the number of arguments provided
    narginchk(1, 7);

    %%%%%%%%%%%%%%%%%%%%%%%%
    % the case if only the name of the file was provided 'cause there's 
    % a need to determine the standard- and deviant_event_mark
    if nargin > 1
        for i = 1:2:numel(varargin)
            if ischar(varargin{i})
                if strcmp(varargin{i}, 'bandpass')
                    bandpass = varargin{i+1};
                    for chan = 1:size(EEG.data, 1)
                        EEG.data(chan, :) = filtfilt(bandpass.sosMatrix, bandpass.ScaleValues, EEG.data(chan, :));
                    end
                elseif strcmp(varargin{i}, 'highpass')
                    highpass = varargin{i+1};
                    for chan = 1:size(EEG.data, 1)
                        EEG.data(chan, :) = filtfilt(highpass.sosMatrix, highpass.ScaleValues, EEG.data(chan, :));
                    end
                elseif strcmp(varargin{i}, 'lowpass')
                    lowpass = varargin{i+1};
                    for chan = 1:size(EEG.data, 1)
                        EEG.data(chan, :) = filtfilt(lowpass.sosMatrix, lowpass.ScaleValues, EEG.data(chan, :));
                    end
                elseif strcmp(varargin{i}, 'bandstop')
                    bandstop = varargin{i+1};
                    for chan = 1:size(EEG.data, 1)
                        EEG.data(chan, :) = filtfilt(bandstop.sosMatrix, bandstop.ScaleValues, EEG.data(chan, :));
                    end
                else
                    disp('unsupported filter type!')
                end
            end
        end
    else
        disp('you have to enter eeg and filter file!')
    end