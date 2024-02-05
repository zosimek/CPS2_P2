function [standard, deviant, time] = epoch_channel(EEG, channel, events, standard_event_mark, deviant_event_mark, baseline_time_period, epoch_time_length)
% OUTPUT:
    %   – EEG: filtered EEG data in EEGLAB format
    %   – channnel: choosen channel EEG.data
    %   – events: choosen (cropped) events
    %   – standard_event_mark: a type of event mark of a standard stimuly
    %   – deviant_event_mark: a type of event mark of a deviant stimuly
    %   – baseline_time_period: time in [s] before event
    %   – epoch_time_length: time in [s] after event
    % INPUT:
    %   – standard [array[array]] of epochs where row == channel, col ==
    %   epoch number
    %   – deviant [array[array]] of epochs where row == channel, col ==
    %   epoch number
    %   – time: epoch time segment data

    % baseline period
    baseline_samples = ceil(EEG.srate * baseline_time_period);
    epoch_samples = ceil(EEG.srate * epoch_time_length);
    %disp(baseline_samples)
    %disp(epoch_time_samples)

    baseline_time_samples = sort(EEG.times(1, 2:baseline_samples + 1) * -1);
    epoch_time_samples = EEG.times(1, 1:epoch_samples);

    time = cat(2, baseline_time_samples, epoch_time_samples);

    % standard simuly epoches

    [standard_events, deviant_events] = count_events(events, standard_event_mark, deviant_event_mark);

    standard = cell(size(32, standard_events), 1);
    deviant = cell(size(32, deviant_events), 1);
    
    standard_col = 1;
    deviant_col = 1;

    for event_no = 1:length(events)
        if strcmp(events(event_no).type, standard_event_mark)
            %disp('standard')
            section_start = events(event_no).latency - baseline_samples + 1;
            section_end = events(event_no).latency + epoch_samples;
            if section_end <= size(channel, 2) && section_start > 0
                dataSegment = channel(1, section_start:section_end);
                standard{1, standard_col} = dataSegment;
            end
            standard_col = standard_col + 1;
        elseif strcmp(events(event_no).type, deviant_event_mark)
            %disp('deviant')
            % get the event edge variables
            section_start = events(event_no).latency - baseline_samples + 1;
            section_end = events(event_no).latency + epoch_samples;
            if section_end <= size(channel, 2) && section_start > 0
                dataSegment = channel(1, section_start:section_end);
                deviant{1, deviant_col} = dataSegment;
            end
            deviant_col = deviant_col + 1;
        % else
        %     disp('none')
        end
    end

    for standard_col=1:size(standard, 1)
        if isempty(standard{1, standard_col})
            standard = standard(:, [1:standard_col-1, standard_col+1:end]);
        end
    end
    for deviant_col=1:size(deviant, 1)
        if isempty(deviant{1, deviant_col})
            deviant = deviant(:, [1:deviant_col-1, deviant_col+1:end]);
        end
    end