function [max_peak_value, max_peak_time, peak_prominence, peak_width] = find_mmn_peak(mmn, time, indices)

% Invert the MMN data within the specified time frame
inverted_mmn = -mmn(indices);

% Find peaks in the inverted data and obtain additional information
[peak_values, peak_locations, peak_widths, peak_prominences] = findpeaks(inverted_mmn, 'WidthReference', 'halfheight');

% Identify the index of the maximum peak
[max_peak_value, max_peak_index] = max(peak_values);

% Find the corresponding time point for the maximum peak
max_peak_time = time(indices(1) + peak_locations(max_peak_index) - 1);

peak_width = peak_widths(max_peak_index);
peak_prominence = peak_prominences(max_peak_index);

disp(['Maximum MMN peak value: ', num2str(max_peak_value)]);
disp(['Time of maximum MMN peak: ', num2str(max_peak_time), ' ms']);
disp(['Width of maximum MMN peak: ', num2str(peak_width), ' ms']);
disp(['Prominence of maximum MMN peak: ', num2str(peak_prominence)]);