%% Bus loading function

function [] = bus_prepro(busPath)

busFiles = dir(fullfile(busPath, '*_bus_def.m'));

for ii = 1:length(busFiles)
    [~, busFnName, ~] = fileparts(busFiles(ii).name);
    busCell = eval(busFnName);
    Simulink.Bus.cellToObject(busCell);
end

end