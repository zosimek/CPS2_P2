function [standard, deviant] = filter_averaged(EEG, standard, deviant)

fs = EEG.srate;

fch =  1;    % Cutoff frequency of the highpass filter [Hz]
fcl = 30;    % Cutoff frequency of the lowpass filter [Hz]
    
[b, a] = butter(6, fch / (fs / 2), 'high');
standard = filtfilt(b, a, standard);
deviant = filtfilt(b, a, deviant);


[d, c] = butter(6, fcl / (fs / 2), 'low');
standard = filtfilt(d, c, standard);
deviant = filtfilt(d, c, deviant);