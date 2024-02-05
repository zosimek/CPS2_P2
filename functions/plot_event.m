function plot_event(EEG, standard_event, deviant_event)


for event_no = 1:size(EEG.event, 2)
        if strcmp(EEG.event(event_no).type, standard_event)
            standard_times = EEG.times(EEG.event(event_no).latency);
            figure(1);
            bar(standard_times, 0.5, 1, 'g')
            hold on
        end
        if strcmp(EEG.event(event_no).type, deviant_event)
            deviant_times = EEG.times(EEG.event(event_no).latency);
            figure(1);
            bar(deviant_times, 1, 1, 'r')
            hold on
        end
 end