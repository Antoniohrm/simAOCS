% Bus definition function template

function busCell = environment_bus_def()

% Define bus properties

% User defined

name = strsplit(mfilename, '_'); % Auto name from file name
description = 'Environment bus';

% Default values

headerFile = ''; % Blank by default
dataScope = 'Auto'; % Auto by default
alignment = '-1'; % -1 by default
preserveElemDim = '0'; % 0 by default

% Define bus elements

elementsCellArray = { ... 
    {'gravAccEcef', [3 1], 'double', 'real', 'Sample'}; ... 
    {'velEci', [3 1], 'double', 'real', 'Sample'}; ... 
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