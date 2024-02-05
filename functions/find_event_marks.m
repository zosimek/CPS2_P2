function [standard_event_mark, deviant_event_mark] = find_event_marks(EEG)

addpath('C:\Program Files\MATLAB\R2023b\toolbox\matlab\fieldtrip-master\external\eeglab');
addpath('C:\Program Files\MATLAB\R2023b\toolbox\matlab\fieldtrip-master\external\ANTeepimport1.13');

% Extract the first column of EEG.event.type (event marks/names)
event_types_cell = {EEG.event.type};

% Get unique event types
unique_types = unique(event_types_cell);

% Initialize a cell array to store types and their counts
types_and_counts = cell(length(unique_types), 2);

% Loop through unique types and count their occurrences
for i = 1:length(unique_types)
    types_and_counts{i, 1} = unique_types{i};
    types_and_counts{i, 2} = sum(strcmp(event_types_cell, unique_types{i}));
end

% Find the indices of the highest and second-highest counts
[~, sorted_indices] = sort(cell2mat(types_and_counts(:, 2)), 'descend');

% Extract the event types with the highest and second-highest counts
standard_event_mark = types_and_counts{sorted_indices(1), 1};
deviant_event_mark = types_and_counts{sorted_indices(2), 1};

