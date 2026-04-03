%
% This script runs a single simulation shot using the given input file
%
% Previous execution of "sim_main.m" is required
%

%% Used-defined inputs
% Uncomment the following lines if any of the parameters defined in
% "sim_main.m" need to be changed

% inputFile = 'input_v1'; % Name of the file with the inputs

% resName0 = 'Res_test'; % Name of the results
% resFolder = fullfile(resultsPath, resName0); % Needed if the results name are updated
% saveRes = true; % Flag to signal whether to save the simulation results
% owRes = false; % Flag to signal whether to overwrite results if "resName" already exists

%% Start timers

simTimer = tic; % Simulation timer
preproTimer = tic; % Simulation prepro timer

%% Print simulation information to user

fprintf('\nInitializing simulator\n');
fprintf('----------------------\n\n');

% Print parameters

fprintf(' - Simulator name: %s\n', simModel);
fprintf(' - Input file: %s\n', inputFile);
if saveRes
    fprintf(' - Results name: %s\n', resName);
end
fprintf(' - Results saving: %d\n', saveRes);
fprintf(' - Results overwriting: %d\n', owRes);
fprintf(' - Simulation time span: %d s\n\n', simTimeSpan);

%% Run prepro

simData = sim_prepro(inputFile); % Prepro input data
bus_prepro(busPath); % Load non-virtual buses

%% Check whether the results folder already contains data

if saveRes

    if isfolder(resFolder)

        resContents = dir(resFolder);
        resContents = resContents(~ismember({resContents.name}, {'.', '..'}));
        
        if ~isempty(resContents)
            [resFolder, resName] = ... 
                createFolder(fullfile(resultsPath, resName0), owRes);
        end

    else

        [resFolder, resName] = ... 
            createFolder(resFolder, owRes);

    end

end

tPrepro = toc(preproTimer); % Preprocessing duration [s]

%% Run simulation

clear('simulationOut'); % Refresh variable

set_param(simModel, 'StopTime', num2str(simTimeSpan)); % Simulation time span
set_param(simModel, 'FixedStep', num2str(simData.sim.simTimeStep)); % Simulation time step
set_param(simModel, 'SimulationMode', simData.sim.simSimulationMode); % Simulation mode

simulationOut = sim(simModel); % Run the simulation

%% Store results

if saveRes

    storeRes( ... 
        simulationOut, ... 
        resFolder, ... 
        simData, ... 
        simModel, ... 
        inputFile, ... 
        simTimeSpan, ... 
        false);

end

%% Print timers

tSim = toc(simTimer); % Simulation duration [s]

fprintf('\nPreprocessing took %5.2f s\n', tPrepro);
fprintf('\nSimulation took %5.2f s\n', tSim);

fprintf('\n----------------------\n\n');