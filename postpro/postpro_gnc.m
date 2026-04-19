%
% Postpro of the GNC variables
%

function [] = postpro_gnc(resName)

%% Identify whether it is a MC run

resContents = dir(strcat('results/', resName));
resContents = resContents(~ismember({resContents.name}, {'.', '..', '.DS_Store'}));

if length(resContents) == 1
    isMC = false;
else
    isMC = true;
end

%% Select signals for postpro

signals2plot = { ... 
    'simTime', ... 
    'gncMode', ... 
    'rwTorqueCmd', ... 
    'mtqVoltageCmd', ... 
    'rcsThrustCmd', ... 
    'omgBodNav', ... 
    'rwOmgRWE'};

%% Initialize figure

fig = figure('Name', 'GNC postpro');

tabNames = { ... 
    'Commands', ... 
    'Modes'};

tabGroup = uitabgroup;
tabs = cell(size(tabNames)); % Preallocate

for ii = 1:numel(tabNames)

    tabs{ii} = uitab( ... 
        tabGroup, ... 
        'Title', tabNames{ii}, ... 
        'BackgroundColor', 'w');

end

tabii = 0;

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

    %% Command variables
    
    % Switch figure

    tabii = tabii + 1;
    axes('Parent', tabs{tabii});

    % Plot
    
    % RW commanded torque

    subplot(3, 1, 1);

    hold on;

    for ii = 1:size(rwTorqueCmd, 1)

        af = ii / size(rwTorqueCmd, 1);
        pColor = [1 - af, af, 1];
        pLeg = sprintf('RW %d', ii);

        plot( ... 
            simTime, ... 
            rwTorqueCmd(ii, :), ... 
            'Color', pColor, ... 
            'LineWidth', 2, ... 
            'DisplayName', pLeg);

    end
    
    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('Torque $ _{RW}$ [Nm]', 'Interpreter', 'latex');
    title('RW commanded torque vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    legend('Interpreter', 'latex');

    % MTQ commanded voltage

    subplot(3, 1, 2);

    hold on;

    for ii = 1:size(mtqVoltageCmd, 1)

        af = ii / size(mtqVoltageCmd, 1);
        pColor = [1 - af, af, 1];
        pLeg = sprintf('MTQ %d', ii);

        plot( ... 
            simTime, ... 
            mtqVoltageCmd(ii, :), ... 
            'Color', pColor, ... 
            'LineWidth', 2, ... 
            'DisplayName', pLeg);

    end
    
    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('$V _{MTQ}$ [V]', 'Interpreter', 'latex');
    title('MTQ commanded voltage vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    legend('Interpreter', 'latex');

    % RCS commanded thrust

    subplot(3, 1, 3);

    hold on;

    for ii = 1:size(rcsThrustCmd, 1)

        af = ii / size(rcsThrustCmd, 1);
        pColor = [1 - af, af, 0];
        pLeg = sprintf('Thruster %d', ii);

        plot( ... 
            simTime, ... 
            rcsThrustCmd(ii, :), ... 
            'Color', pColor, ... 
            'LineWidth', 2, ... 
            'DisplayName', pLeg);

    end
    
    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('$T _{RCS}$ [N]', 'Interpreter', 'latex');
    title('RCS commanded thrust vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    legend('Interpreter', 'latex');

    %% Mode variables
    
    % Switch figure

    tabii = tabii + 1;
    axes('Parent', tabs{tabii});

    % Plot
    
    % Current mode

    subplot(2, 2, [1, 2]);

    hold on;

    for ii = 1:size(rwTorqueCmd, 1)

        plot( ... 
            simTime, ... 
            gncMode, ... 
            'Color', 'b', ... 
            'LineWidth', 2);

    end

    yticks([simData.gnc.modes.modeIds{:, 2}]); % Y ticks values
    yticklabels([simData.gnc.modes.modeIds{:, 1}]); % Y ticks labels

    ylim( ... 
        [0.9 * min(yticks), ... 
        1.1 * max(yticks)]); % Y axis range
    
    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('Mode', 'Interpreter', 'latex');
    title('GNC mode vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    % Body angular velocities Safe mode threshold

    subplot(2, 2, 3);

    hold on;

    plot( ... 
        [min(simTime), max(simTime)], ... 
        (simData.gnc.modes.omgBodSafeTH * (180 / pi)) .* ones(1, 2), ... 
        'Color', 'r', ... 
        'LineStyle', ':', ... 
        'LineWidth', 2, ... 
        'DisplayName', 'Safe mode threshold'); % Safe mode threshold

    for ii = 1:size(omgBodNav, 1)

        af = ii / size(omgBodNav, 1);
        pColor = [1 - af, af, 1];
        pLeg = {'$$X_{BOD}$$', '$$Y_{BOD}$$', '$$Z_{BOD}$$'};

        plot( ... 
            simTime, ... 
            abs(omgBodNav(ii, :)) .* (180 / pi), ... 
            'Color', pColor, ... 
            'LineStyle', '-', ... 
            'LineWidth', 2, ... 
            'DisplayName', pLeg{ii});

    end

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('$\omega _{BOD}^{Nav}$ [$^{\circ}s^{-1}$]', 'Interpreter', 'latex');
    title('Measured Body angular velocities vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    legend('Interpreter', 'latex');

    % RW angular velocities Desaturation mode threshold

    subplot(2, 2, 4);

    hold on;

    plot( ... 
        [min(simTime), max(simTime)], ... 
        (simData.rw.rwMaxOmg(1) * (30 / pi)) .* ... 
        simData.gnc.modes.omgRwDesaturationTH .* ... 
        ones(1, 2), ... 
        'Color', 'r', ... 
        'LineStyle', ':', ... 
        'LineWidth', 2, ... 
        'DisplayName', 'Desaturation mode trigger threshold'); % Safe mode trigger threshold (assuming the limits for all RW are the same)

    plot( ... 
        [min(simTime), max(simTime)], ... 
        (simData.rw.rwMaxOmg(1) * (30 / pi)) .* ... 
        simData.gnc.modes.omgRwDesaturationEndTH .* ... 
        ones(1, 2), ... 
        'Color', 'g', ... 
        'LineStyle', ':', ... 
        'LineWidth', 2, ... 
        'DisplayName', 'Desaturation mode exit threshold'); % Safe mode exit threshold (assuming the limits for all RW are the same)

    for ii = 1:size(rwOmgRWE, 1)

        af = ii / size(rwOmgRWE, 1);
        pColor = [1 - af, af, 1];
        pLeg = sprintf('RW %d', ii);

        plot( ... 
            simTime, ... 
            abs(rwOmgRWE(ii, :)) .* (30 / pi), ... 
            'Color', pColor, ... 
            'LineStyle', '-', ... 
            'LineWidth', 2, ... 
            'DisplayName', pLeg);

    end

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('$\omega _{RW}^{Nav}$ [rpm]', 'Interpreter', 'latex');
    title('Measured RW angular velocities vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    legend('Interpreter', 'latex');

end

end