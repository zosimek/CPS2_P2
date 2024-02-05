function [EEG, standard_event_mark, deviant_event_mark] = paradigm_evaluation(cnt_files_path, file_name, file_duration_mark, file_frequency_mark, duration_standard, duration_deviant, frequency_standard, frequency_deviant)

% The function uses load_EEG_from_cnt to load EEG data, based on
% paradigm_evaluation

addpath("eeglab\", "ANTeepimport1.13\", "functions\", "app\");

if cnt_files_path(end) == "\"
    file_name_path = strcat(cnt_files_path, file_name);
else 
    dash = '\';
    file_name_path = strcat(cnt_files_path, dash, file_name);
end

% In our dataset the files are arranges in such a way, that the files
% containing data in frequency paradigm have "frequency" in the file name
% and the ones in duration paradigm have "duration".

% Also duration has event marks like so: "17" standard event, "18" deviant
% event, and frequency: "15" standard event, and "16" deviant event.

containsDuration = contains(file_name, file_duration_mark);
containsFrequency = contains(file_name, file_frequency_mark);
if containsDuration == 1
    [EEG, standard_event_mark, deviant_event_mark] = load_EEG_from_cnt(file_name_path, duration_standard, duration_deviant);
end
if containsFrequency == 1
    [EEG, standard_event_mark, deviant_event_mark] = load_EEG_from_cnt(file_name_path, frequency_standard, frequency_deviant);
end

[EEG, standard_event_mark, deviant_event_mark] = load_EEG_from_cnt(file_name_path, frequency_standard, frequency_deviant);

EEG.data = double(EEG.data);