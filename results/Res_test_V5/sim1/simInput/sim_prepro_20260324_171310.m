%
% This function preprocesses the input data declared in the supplied input
% file
%
% Input(s):
%   - inpFileName: String, name of the selected input function
%
% Output(s):
%   - simData: Struct, simulation data
%

function [simData] = sim_prepro(inpFileName)

simData = struct(); % Initialize output

eval(inpFileName); % Load input data into this function's workspace

end