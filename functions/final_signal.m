function [mmn, standard_final, deviant_final, time] = final_signal(EEG, channel_of_choice, standard_event_mark, deviant_event_mark, threshold, events_to_delate)
    
    EEG.event_croped = crop_events(EEG, standard_event_mark, deviant_event_mark, threshold, events_to_delate);
    
    EEG = filter_EEG(EEG);

    for channel = 1:size(EEG.chanlocs, 2)
        chaname = strrep(lower(EEG.chanlocs(channel).labels), " ", "");
        if strcmp(chaname, channel_of_choice)
            row = channel;
        end
    end

    EEG.choosen_channel = EEG.filtered;
    EEG.choosen_channel(1:row-1, :) = [];
    EEG.choosen_channel(row:end, :) = [];
    
    [standard, deviant, time] = epoch_channel(EEG, EEG.choosen_channel, EEG.event_croped, standard_event_mark, deviant_event_mark, 0.1, 0.5);
    [standard_bc, deviant_bc] = baseline_epochs(standard, deviant, time);
    [standard_avg, deviant_avg] = average_channels_epochs(standard_bc, deviant_bc, time);

    [standard_final, deviant_final] = filter_averaged(EEG, standard_avg, deviant_avg);

    mmn = deviant_avg - standard_avg;