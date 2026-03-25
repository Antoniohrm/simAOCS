%
% Store simulation logged signals, inputs and metadata
%

function [] = storeRes( ... 
    simulationOut, ... 
    resFolder, ... 
    simData, ... 
    simModel, ... 
    inputFile, ... 
    simTimeSpan, ... 
    isMC, ... 
    simN)

%% Handle results ids

if isMC
    simii = simN;
else
    simii = 1;
end

resFolder = fullfile(resFolder, strcat('sim', num2str(simii)));

%% Generate results folder structure

inpFName = fullfile(resFolder, 'simInput');
dataFName = fullfile(resFolder, 'data');

mkdir(inpFName);
mkdir(dataFName);

%% Store simulation metadata

simMetaData = struct(); % Preallocate

simMetaData.simModel = simModel;
simMetaData.inputFile = inputFile;
simMetaData.simTimeSpan = simTimeSpan;
simMetaData.simDateTime = datestr(now, 'yyyymmdd_HHMMSS'); % Day and time of the simulation

save(fullfile(resFolder, 'simMetadata'), 'simMetaData');

%% Store simulation inputs

% Input file

inpFileName2save = strcat(inputFile, '_', simMetaData.simDateTime);

copyfile(fullfile('input', strcat(inputFile, '.m')), ... 
    strcat(fullfile(inpFName, inpFileName2save), '.m'));

% Prepro function

preproFileName2save = strcat('sim_prepro_', simMetaData.simDateTime);

copyfile('prepro/sim_prepro.m', ... 
    strcat(fullfile(inpFName, preproFileName2save), '.m'));

save( ... 
    fullfile(inpFName, 'simData'), 'simData');

%% Save logged signals

% Identify Matlab version to extract logged data properly

v = ver;
ii = 1;
foundFlag = false;

while ii <= length(v) & (~foundFlag)
    if strcmpi(v(ii).Name, 'matlab')
        mVer = str2num(v(ii).Version);
        foundFlag = true;
    else
        ii = ii + 1;
    end
end

if mVer < 25.2
    
    % For MATLAB previous to R2025b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    on = simulationOut.who; % Field names
    
    if ~isempty(find(strcmpi(on, 'logsout')))
    
        nLoggedSignals = length(simulationOut.logsout);
    
        % Initialize the logging process
        fprintf('\nStoring %d logged signal/s...\n\n', nLoggedSignals);
    
        simTime = simulationOut.tout;
        save(fullfile(dataFName, 'simTime'), 'simTime');
        fprintf('Saved simulation time\n');
    
        for ii = 1:nLoggedSignals
        
            varName = simulationOut.logsout{ii}.Name;
            data = squeeze(simulationOut.logsout{ii}.Values.Data);
            eval(strcat(varName, '= data;'));
    
            save(fullfile(dataFName, varName), varName);
            fprintf('Saved signal: %s\n', varName);
        
        end
    
        fprintf('\nLogging completed\n');
    
    else
    
        fprintf('\nNo signals were logged during the simulation\n');
    
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

else

    % For MATLAB version R2025b and later %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    on = simulationOut.who; % Field names
    
    if ~isempty(find(strcmpi(on, 'logsout')))
    
        nLoggedSignals = simulationOut.logsout.numElements;
    
        % Initialize the logging process
        fprintf('\nStoring %d logged signal/s...\n\n', nLoggedSignals);
    
        simTime = simulationOut.tout;
        save(fullfile(dataFName, 'simTime'), 'simTime');
        fprintf('Saved simulation time\n');
    
        for ii = 1:nLoggedSignals
        
            varName = simulationOut.logsout.getElementNames{ii};
            varSignal = simulationOut.logsout.getElement(varName);
            data = squeeze(varSignal.Values.Data);
            eval(strcat(varName, '= data;'));
    
            save(fullfile(dataFName, varName), varName);
            fprintf('Saved signal: %s\n', varName);
        
        end
    
        fprintf('\nLogging completed\n');
    
    else
    
        fprintf('\nNo signals were logged during the simulation\n');
    
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end

end