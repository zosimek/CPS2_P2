function chanlocs = add_chanlosc(elcFilePath)
    % Read the .elc file as text
    elcText = fileread(elcFilePath);

    % Extract electrode information
    expression = '([\w\s]+)\s+([-.\d]+)\s+([-.\d]+)\s+([-.\d]+)';
    matches = regexp(elcText, expression, 'tokens');

    % Create channel locations structure
    chanlocs = struct('labels', {}, 'X', {}, 'Y', {}, 'Z', {});
    for i = 1:numel(matches)
        chanlocs(i).labels = strtrim(matches{i}{1});
        chanlocs(i).X = str2double(matches{i}{2});
        chanlocs(i).Y = str2double(matches{i}{3});
        chanlocs(i).Z = str2double(matches{i}{4});
    end
end