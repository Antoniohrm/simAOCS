%
% Postpro of the actuator variables
%

function [] = postpro_actuators(resName)

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
    'simTime', ... 
    'rwOmg', ... 
    'mtqMagDip', ... 
    'rcsThrust', ... 
    'rcsMdot'};

%% Initialize figure

fig = figure('Name', 'Actuators postpro');

tabNames = { ... 
    'Actuators'};

tabGroup = uitabgroup;
tabs = cell(size(tabNames)); % Preallocate

for ii = 1:numel(tabNames)

    tabs{ii} = uitab( ... 
        tabGroup, ... 
        'Title', tabNames{ii}, ... 
        'BackgroundColor', 'k');

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

    %% Actuator variables
    
    % Switch figure

    tabii = tabii + 1;
    axes('Parent', tabs{tabii});

    % Plot
    
    % RW velocities

    subplot(2, 2, 1);

    hold on;

    for ii = 1:size(rwOmg, 1)

        af = ii / size(rwOmg, 1);
        pColor = [1 - af, af, 1];
        pLeg = sprintf('RW %d', ii);

        plot( ... 
            simTime, ... 
            rwOmg(ii, :) .* (30 / pi), ... 
            'Color', pColor, ... 
            'LineWidth', 2, ... 
            'DisplayName', pLeg);

    end
    
    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('$\omega _{RW}$ [rpm]', 'Interpreter', 'latex');
    title('RW angular velocity vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    legend('Interpreter', 'latex');

    % MTQ magnetic dipoles

    subplot(2, 2, 2);

    hold on;

    for ii = 1:size(mtqMagDip, 1)

        af = ii / size(mtqMagDip, 1);
        pColor = [1 - af, af, 1];
        pLeg = sprintf('MTQ %d', ii);

        plot( ... 
            simTime, ... 
            mtqMagDip(ii, :), ... 
            'Color', pColor, ... 
            'LineWidth', 2, ... 
            'DisplayName', pLeg);

    end
    
    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('$m _{MTQ}$ [$Am^{2}$]', 'Interpreter', 'latex');
    title('MTQ magnetic dipole vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    legend('Interpreter', 'latex');

    % RCS thrust

    subplot(2, 2, 3);

    hold on;

    for ii = 1:size(rcsThrust, 1)

        af = ii / size(rcsThrust, 1);
        pColor = [1 - af, af, 0];
        pLeg = sprintf('Thruster %d', ii);

        plot( ... 
            simTime, ... 
            rcsThrust(ii, :), ... 
            'Color', pColor, ... 
            'LineWidth', 2, ... 
            'DisplayName', pLeg);

    end
    
    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('$T _{RCS}$ [N]', 'Interpreter', 'latex');
    title('RCS thrust vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    legend('Interpreter', 'latex');

    % RCS mass flow rate

    subplot(2, 2, 4);

    hold on;

    for ii = 1:size(rcsMdot, 1)

        af = ii / size(rcsMdot, 1);
        pColor = [1 - af, af, 0];
        pLeg = sprintf('Thruster %d', ii);

        plot( ... 
            simTime, ... 
            rcsMdot(ii, :), ... 
            'Color', pColor, ... 
            'LineWidth', 2, ... 
            'DisplayName', pLeg);

    end
    
    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('$\dot{m} _{RCS}$ [$kgs^{-1}$]', 'Interpreter', 'latex');
    title('RCS mass flow rate vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    legend('Interpreter', 'latex');

end

end