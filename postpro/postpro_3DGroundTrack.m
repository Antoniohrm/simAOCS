%
% 3D ground track (requires mapping toolbox)
%

function [] = postpro_3DGroundTrack(resName)

%% Identify whether it is a MC run

resContents = dir(strcat('results/', resName));
resContents = resContents(~ismember({resContents.name}, {'.', '..'}));

if length(resContents) == 1
    isMC = false;
else
    isMC = true;
end

%% Select signals for postpro

signals2plot = { ... 
    'posLLA'};

%% Initialize UI figure

uifig = uifigure('Name', '3D ground track');

g = geoglobe(uifig);

%% Single shot

if ~isMC

    %% Load variables

    dataFolder = strcat('results/', resName, '/sim1/data/');

    for ii = 1:numel(signals2plot)

        signalFile = strcat( ... 
            dataFolder, ... 
            signals2plot{ii}, ... 
            '.mat'); % Data file

        load( ... 
            signalFile, ... 
            signals2plot{ii}); % Load data

    end
    
    inpDataFile = ... 
        strcat( ... 
        'results/', ... 
        resName, ... 
        '/sim1/simInput/simData.mat');

    load(inpDataFile, 'simData');

    %% Plot

    geoplot3( ... 
        g, ... 
        posLLA(1, :) .* (180 / pi), ... 
        posLLA(2, :) .* (180 / pi), ... 
        posLLA(3, :), ... 
        'b', ... 
        'LineWidth', 2);

end

end
