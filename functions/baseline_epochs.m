function [standard, deviant] = baseline_epochs(standard, deviant, time)
    % Find indices corresponding to time points < 0
    baseline_indices = find(time < 0);

    % Calculate baseline correction for each channel
    for channel = 1:size(standard, 1)
        for epoch = 1:size(standard, 2)
            standard_one_epoch = standard(channel, epoch);
            standard_epoch_data = standard_one_epoch{1, :};

            baseline_mean_standard = mean(standard_epoch_data(1, baseline_indices(1, 1):baseline_indices(1, end)));
            standard_epoch_data = standard_epoch_data - baseline_mean_standard;

            standard(channel, epoch) = {standard_epoch_data};
        end
        for epoch = 1:size(deviant, 2)
            deviant_one_epoch = deviant(channel, epoch);
            deviant_epoch_data = deviant_one_epoch{1, :};

            baseline_mean_deviant = mean(deviant_epoch_data(1, baseline_indices(1, 1):baseline_indices(1, end)));
            deviant_epoch_data = deviant_epoch_data - baseline_mean_deviant;

            deviant(channel, epoch) = {deviant_epoch_data};
        end
    end
end
