function event_data = crop_events(EEG, standard_event_mark, deviant_event_mark, threshold, events_to_delate)

% The function creates a new variable based on EEG.event variable in sucha
% a way, that it cuts off the first few "trials" (events_to_delete) and
% leaves the rest, on condition that the full standard_event length id
% equal or greater than threshold (so for each deviant_event we will obtain
% at least [threshold - events_to_delete] standard_events).

event_data = EEG.event;

event_no_reversed = size(event_data, 2);
while event_no_reversed > 0
    if strcmp(strtrim(event_data(event_no_reversed).type), standard_event_mark) || strcmp(strtrim(event_data(event_no_reversed).type), deviant_event_mark)
        if event_data(event_no_reversed).number >= threshold
            event_no_reversed = event_no_reversed - (event_data(event_no_reversed).number - events_to_delate);
        elseif event_data(event_no_reversed).number == 0
            if event_data(event_no_reversed - 1).number >= threshold
                event_no_reversed = event_no_reversed - 1;
            else
                event_data(event_no_reversed) = [];
                event_no_reversed = event_no_reversed - 1;
            end
        else 
             event_data(event_no_reversed) = [];
             event_no_reversed = event_no_reversed - 1;
        end
     else
         event_data(event_no_reversed) = [];
         event_no_reversed = event_no_reversed - 1;
    end
end