function EEG = filter_EEG(EEG)

    fs = EEG.srate;

    fch =  1;    % Cutoff frequency of the highpass filter [Hz]
    fcl = 30;    % Cutoff frequency of the lowpass filter [Hz]
    
    EEG.filtered = zeros(size(EEG.data));
    
    [b, a] = butter(6, fch / (fs / 2), 'high');
    
    for channel = 1 : size(EEG.data, 1)
        EEG.filtered(channel, :) = filtfilt(b, a, EEG.data(channel, :));
    end
    [d, c] = butter(6, fcl / (fs / 2), 'low');
    for channel = 1 : size(EEG.data, 1)
        EEG.filtered(channel, :) = filtfilt(d, c, EEG.filtered(channel, :));
    end
