%add paths
addpath("eeglab\", "ANTeepimport1.13\", "functions\", "app\");
clear; close all;
%% %%%%%%%% static values

cnt_files_path = 'data\';
save_directory = 'inspect_outcome\';

file_duration_mark = "duration";
file_frequency_mark = "frequency";
duration_standard = "17";
duration_deviant = "18";
frequency_standard = "15";
frequency_deviant = "16";

channel_of_choice = lower("Fz");

%%
[cnt_file_names, num_cnt_files] = load_cnt_from_dir(cnt_files_path);
peak_values = cell(1,1);


for file = 1:num_cnt_files

    file_name = cnt_file_names{file, 1};
    disp(file_name)

    % load EEG data along with its event markers
    % EEG.data in type double
    [EEG, standard_event_mark, deviant_event_mark] = paradigm_evaluation(cnt_files_path, file_name, file_duration_mark, file_frequency_mark, duration_standard, duration_deviant, frequency_standard, frequency_deviant);

    % numbering standard events between deviant
    EEG = number_events(EEG, standard_event_mark, deviant_event_mark);
    
    [mmn_1, standard_final_1, deviant_final_1, time] = final_signal(EEG, channel_of_choice, standard_event_mark, deviant_event_mark, 7, 2);
    [mmn_2, standard_final_2, deviant_final_2, time_2] = final_signal(EEG, channel_of_choice, standard_event_mark, deviant_event_mark, 9, 4);
    [mmn_3, standard_final_3, deviant_final_3, time_3] = final_signal(EEG, channel_of_choice, standard_event_mark, deviant_event_mark, 12, 7);

    %% Finding peaks

    start_peak_time = 95;  % in ms
    end_peak_time = 205;   % in ms
    indices = find(time >= start_peak_time & time <= end_peak_time);

    disp("<2-7>")
    [max_peak_value_1, max_peak_time_1, peak_prominence_1, peak_width_1] = find_mmn_peak(mmn_1, time, indices);
    disp("<4-9>")
    [max_peak_value_2, max_peak_time_2, peak_prominence_2, peak_width_2] = find_mmn_peak(mmn_2, time, indices);
    disp("<7-12>")
    [max_peak_value_3, max_peak_time_3, peak_prominence_3, peak_width_3] = find_mmn_peak(mmn_3, time, indices);
    %% Ploting
    figure;

    % Create the first subplot
    subplot(3, 1, 1);
    plot(time, standard_final_1, 'b')
    hold on;
    plot(time, deviant_final_1, 'r')
    hold on;
    plot(time, mmn_1(1, :), 'g')
    hold on;
    scatter(max_peak_time_1, -max_peak_value_1, 10, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k');
    title("Fz")
    xline(0, '--', 'Color', 'k', 'LineWidth', 1);
    legend('Standard', 'Deviant', 'MMN')
    xlim([-100 500])
    xlabel('time [ms]')
    ylabel('amplitude [\mu V]')
    title('threshold: 7, cut off: 2')
    
    % Create the second subplot
    subplot(3, 1, 2);
    plot(time, standard_final_2, 'b')
    hold on;
    plot(time, deviant_final_2, 'r')
    hold on;
    plot(time, mmn_2(1, :), 'g')
    hold on;
    scatter(max_peak_time_2, -max_peak_value_2, 10, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k');
    title("Fz")
    xline(0, '--', 'Color', 'k', 'LineWidth', 1);
    legend('Standard', 'Deviant', 'MMN')
    xlim([-100 500])
    xlabel('time [ms]')
    ylabel('amplitude [\mu V]')
    title('threshold: 9, cut off: 4')
    
    % Create the third subplot
    subplot(3, 1, 3);
    plot(time, standard_final_3, 'b')
    hold on;
    plot(time, deviant_final_3, 'r')
    hold on;
    plot(time, mmn_3(1, :), 'g')
    hold on;
    scatter(max_peak_time_3, -max_peak_value_3, 10, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k');
    title("Fz")
    xline(0, '--', 'Color', 'k', 'LineWidth', 1);
    legend('Standard', 'Deviant', 'MMN')
    xlim([-100 500])
    xlabel('time [ms]')
    ylabel('amplitude [\mu V]')
    title('threshold: 12, cut off: 7')
    
    % Adjust the layout
    annotation('textbox', [0.5, 0.95, 0.1, 0.05], 'String', file_name, 'HorizontalAlignment', 'center', 'FontSize', 10, 'FontWeight', 'bold', 'Interpreter', 'none', 'EdgeColor', 'none');


    % figure(1)
    % plot(time, standard_final, 'b')
    % hold on;
    % plot(time, deviant_final, 'r')
    % hold on;
    % plot(time, mmn(1, :), 'g')
    % title("Fz")
    % xline(0, '--', 'Color', 'k', 'LineWidth', 1);
    % legend('Standard', 'Deviant', 'MMN')
    % xlim([-100 500])
    % xlabel('time [ms]')
    % ylabel('amplitude [\mu V]')
    % 
    % annotation('textbox', [0.5, 0.95, 0.1, 0.05], 'String', ([file_name, " - Fz"]), 'HorizontalAlignment', 'center', 'FontSize', 14, 'FontWeight', 'bold', 'Interpreter', 'none', 'EdgeColor', 'none');
    file_name = file_name(1:end-4);
    saveas(gcf, fullfile(save_directory, file_name));
    file_name = file_name + ".png";
    saveas(gcf, fullfile(save_directory, file_name));
    close(gcf);
end
