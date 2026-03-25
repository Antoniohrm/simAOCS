%
%
%

function [fPath, fName] = createFolder(fPath0, owFlag)


if isfolder(fPath0)

    if owFlag

        rmdir(fPath0, 's'); % Delete old results to avoid duplicates
        fPath = fPath0;

    else

        ii = 1;

        fPath = strcat(fPath0, '_V', num2str(ii));

        while isfolder(fPath)
            ii = ii + 1;
            fPath = strcat(fPath0, '_V', num2str(ii));
        end

    end

else

    fPath = fPath0;

end

%% Get final folder name

[~, fName, ~] = fileparts(fPath);

%% Create folder

mkdir(fPath);

fprintf('Created folder %s\n', fPath);


end