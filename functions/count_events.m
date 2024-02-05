function [standard_events, deviant_events] = count_events(events, standard_event_mark, deviant_event_mark)
    standard_events = 0;
    deviant_events = 0;

    for event_no = 2:length(events)
        if strcmp(strtrim(events(event_no).type), standard_event_mark)
            standard_events = standard_events + 1;
        elseif strcmp(strtrim(events(event_no).type), deviant_event_mark)
            deviant_events = deviant_events + 1;
         else
             disp('no such event mark')
        end
    end