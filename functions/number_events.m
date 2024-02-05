function EEG = number_events(EEG, standard_event_mark, deviant_event_mark)

% The function numberes the events in such a fassion:
% deviant_event = 0
% following standard_events in increasing numbers from 1 to n 
% (n being the number of standard_events between deviant_events)
% The numbers are added as a new column, called "number" in EEG.event
    
i = 0;
for event_no = 1:size(EEG.event, 2)
    if strcmp(strtrim(EEG.event(event_no).type), standard_event_mark)
        i = i + 1;
        EEG.event(event_no).number = i;
    elseif strcmp(strtrim(EEG.event(event_no).type), deviant_event_mark) && i ~= 0
        i = 0;
        EEG.event(event_no).number = i;
    end
end