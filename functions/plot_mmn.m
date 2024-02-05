function plot_mmn(file_name, cnt_file_path, save_directory)

dash = '\';
file_name_path = strcat(cnt_file_path, dash, file_name);

% determine if frequency or duration experiment type
% Check if the string contains 'duration'

containsDuration = contains(file_name, 'duration');
% Check if the string contains 'frequency'
containsFrequency = contains(file_name, 'frequency');
if containsDuration == 1
    [EEG, standard_event_mark, deviant_event_mark] = load_EEG_from_cnt(file_name_path, '17', '18');
end
if containsFrequency == 1
    [EEG, standard_event_mark, deviant_event_mark] = load_EEG_from_cnt(file_name_path, '15', '16');
end

%[EEG, standard_event_mark, deviant_event_mark] = load_EEG_from_cnt(file_name_path);
EEG.data = double(EEG.data);

EEG_filtered = filter_EEG(EEG);

[standard_filtered, deviant_filtered, time_filtered] = epoch_EEG(EEG_filtered, EEG.event, standard_event_mark, deviant_event_mark, 0.1, 0.5);
[standard_bc_filt, deviant_bc_filt] = baseline_epochs(standard_filtered, deviant_filtered, time_filtered);
[standard_filt_avg, deviant_filt_avg] = average_channels_epochs(standard_bc_filt, deviant_bc_filt, time_filtered);

file_name = strrep(file_name, '.cnt', '');
fig = figure('Name', file_name);
set(fig, 'units', 'normalized', 'outerposition', [0 0 1 1]);

figure(1)
for channel = 1:size(deviant_filt_avg, 1)
     subplot(8, 4, channel)
     mmn = deviant_filt_avg(channel, :) - standard_filt_avg(channel, :);
     plot(time_filtered, standard_filt_avg(channel, :), 'b')
     hold on;
     plot(time_filtered, deviant_filt_avg(channel, :), 'r')
     hold on;
     plot(time_filtered, mmn(1, :), 'g')
     title(EEG.chanlocs(channel).labels)
     xline(0, '--', 'Color', 'k', 'LineWidth', 1);
     legend('Standard', 'Deviant', 'MMN')
     xlim([-100 500])
     xlabel('time [ms]')
     ylabel('amplitude [\mu V]')
end

annotation('textbox', [0.5, 0.95, 0.1, 0.05], 'String', file_name, 'HorizontalAlignment', 'center', 'FontSize', 14, 'FontWeight', 'bold', 'Interpreter', 'none', 'EdgeColor', 'none');
saveas(gcf, fullfile(save_directory, file_name));
close(gcf);
