% Bus definition function template

function busCell = gnc_bus_def()

% Define bus properties

% User defined

name = strsplit(mfilename, '_'); % Auto name from file name
description = 'GNC bus';

% Default values

headerFile = ''; % Blank by default
dataScope = 'Auto'; % Auto by default
alignment = '-1'; % -1 by default
preserveElemDim = '0'; % 0 by default

% Define bus elements

elementsCellArray = { ... 
    {'rwTorqueCmd', [3 1], 'double', 'real', 'Sample'}; ... 
    {'mtqVoltageCmd', [3 1], 'double', 'real', 'Sample'}; ... 
    {'rcsThrustCmd', [12 1], 'double', 'real', 'Sample'}; ... 
    };

% Build bus cell

busCell = {{ ... 
    strcat(name{1}, '_', name{2}), ... 
    headerFile, ... 
    description, ... 
    dataScope, ... 
    alignment, ... 
    preserveElemDim, ... 
    elementsCellArray}};

end