%
% This script is used to declare the main simulation parameters, including
% which input to use, the name of the results file and whether to save the
% results
%
% The input data is also preprocessed and the simulator is loaded
%

%% Set-up environment

clc;
clear;
close all;

initTimer = tic; % Initialization timer

fprintf('\nInitializing simulator\n');
fprintf('----------------------\n\n');

% Path handling

blocksPath = 'blocks';
inputPath = 'input';
preproPath = 'prepro';
postproPath = 'postpro';
resultsPath = 'results';
busPath = 'bus';
auxFnsPath = 'auxFns';
simFnsPath = 'simFns';

addpath(genpath(blocksPath));
addpath(genpath(inputPath));
addpath(genpath(preproPath));
addpath(genpath(postproPath));
addpath(genpath(busPath));
addpath(genpath(auxFnsPath));
addpath(genpath(simFnsPath));

%% Main simulation parameters

simModel = 'SIM_MDL'; % Name of the main simulator Simulink model

% I/O

inputFile = 'input_v1'; % Name of the file with the inputs

resName0 = 'Res_test'; % Name of the results

% saveRes = false; % Flag to signal whether to save the simulation results
saveRes = true; % Flag to signal whether to save the simulation results

owRes = true; % Flag to signal whether to overwrite results if "resName" already exists
% owRes = false; % Flag to signal whether to overwrite results if "resName" already exists

% Simulation

simTimeSpan = 60 * 1; % Simulation time span [s]

%% Initialize simulation

% Run prepro

simData = sim_prepro(inputFile); % Prepro input data
bus_prepro(busPath); % Load non-virtual buses

% Handle results 

if saveRes

    if ~isfolder(resultsPath)
        mkdir(resultsPath);
    end

    [resFolder, resName] = ... 
        createFolder(fullfile(resultsPath, resName0), owRes);

end

% Open simulator

open(simModel);

%% Print initialization data

% Print parameters

fprintf(' - Simulator name: %s\n', simModel);
fprintf(' - Input file: %s\n', inputFile);
if saveRes
    fprintf(' - Results name: %s\n', resName);
end
fprintf(' - Results saving: %d\n', saveRes);
fprintf(' - Results overwriting: %d\n', owRes);
fprintf(' - Simulation time span: %d s\n\n', simTimeSpan);

% Initialization time


tInit = toc(initTimer); % Get initialization time

fprintf('\nInitialization took %5.2f s\n', tInit);
fprintf('\n----------------------\n\n');






