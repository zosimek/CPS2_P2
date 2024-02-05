function [standard_avg, deviant_avg] = average_channels_epochs(standard, deviant, time)
    
    %%dimentions
    sample_lenght = size(time, 2);
    channels_nb = size(standard, 1);

    channel = zeros(1, sample_lenght);
    standard_avg = zeros(channels_nb, sample_lenght);
    deviant_avg = zeros(channels_nb, sample_lenght);
    
    for row = 1:size(standard, 1)
        for col = 1:size(standard, 2)
            % Concatenate the elements to the new channeliable
            channel = [channel; standard{row, col}];
            standard_avg(row,:) = mean(channel, 1);
        end
    end

    channel = zeros(1, sample_lenght);
    for row = 1:size(deviant, 1)
        for col = 1:size(deviant, 2)
            % Concatenate the elements to the new channeliable
            channel = [channel; deviant{row, col}];
            deviant_avg(row,:) = mean(channel, 1);
        end
    end