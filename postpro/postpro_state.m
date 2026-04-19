%
% Postpro of the state variables
%

function [] = postpro_state(resName)

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
    'posEci', ... 
    'velEci', ... 
    'attEci2Bod', ... 
    'omgBod', ... 
    'posEcef', ...
    'velEcef', ... 
    'posLLA', ... 
    'totMass', ... 
    'fuelMass', ... 
    'inertia'};

%% Initialize figure

fig = figure('Name', 'State postpro');

tabNames = { ... 
    'Altitude & Velocity', ... 
    'ECI', ... 
    'ECEF', ... 
    'Ground track', ... 
    '3D trajectory', ... 
    'Attitude', ... 
    'Angular velocity', ... 
    'Mass properties'};

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

    %% Main state variables
    
    % Switch figure

    tabii = tabii + 1;
    axes('Parent', tabs{tabii});

    % Plot
    
    % Altitude

    alt = posLLA(3, :); % Altitude [m]

    subplot(2, 1, 1);

    hold on;

    plot( ... 
        simTime, ... 
        alt .* 1e-3, ... 
        'b', ... 
        'LineWidth', 2);
    
    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('Altitude [km]', 'Interpreter', 'latex');
    title('Altitude vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    % Velocities

    vEciMag = vecnorm(velEci); % Inertial velocity [ms-1]
    vEcefMag = vecnorm(velEcef); % ECEF velocity [ms-1]

    subplot(2, 1, 2);

    hold on;

    plot( ... 
        simTime, ... 
        vEciMag, ... 
        'r', ... 
        'LineWidth', 2, ... 
        'DisplayName', 'ECI');

    plot( ... 
        simTime, ... 
        vEcefMag, ... 
        'g', ... 
        'LineWidth', 2, ... 
        'DisplayName', 'ECEF');

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('Velocity [$ms^{-1}$]', 'Interpreter', 'latex');
    title('Velocity vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    legend('Interpreter', 'latex');

    %% ECI state
    
    % Switch figure

    tabii = tabii + 1;
    axes('Parent', tabs{tabii});

    % Plot

    % X coordinate

    subplot(2, 3, 1);

    hold on;

    plot( ... 
        simTime, ... 
        posEci(1, :), ... 
        'b', ... 
        'LineWidth', 2);

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('X coordinate [m]', 'Interpreter', 'latex');
    title('X coordinate vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    % Y coordinate

    subplot(2, 3, 2);

    hold on;

    plot( ... 
        simTime, ... 
        posEci(2, :), ... 
        'b', ... 
        'LineWidth', 2);

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('Y coordinate [m]', 'Interpreter', 'latex');
    title('Y coordinate vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    % Z coordinate

    subplot(2, 3, 3);

    hold on;

    plot( ... 
        simTime, ... 
        posEci(3, :), ... 
        'b', ... 
        'LineWidth', 2);

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('Z coordinate [m]', 'Interpreter', 'latex');
    title('Z coordinate vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    % X velocity

    subplot(2, 3, 4);

    hold on;

    plot( ... 
        simTime, ... 
        velEci(1, :), ... 
        'b', ... 
        'LineWidth', 2);

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('X velocity [$ms^{-1}$]', 'Interpreter', 'latex');
    title('X velocity vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    % Y velocity

    subplot(2, 3, 5);

    hold on;

    plot( ... 
        simTime, ... 
        velEci(2, :), ... 
        'b', ... 
        'LineWidth', 2);

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('Y velocity [$ms^{-1}$]', 'Interpreter', 'latex');
    title('Y velocity vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    % Z velocity

    subplot(2, 3, 6);

    hold on;

    plot( ... 
        simTime, ... 
        velEci(3, :), ... 
        'b', ... 
        'LineWidth', 2);

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('Z velocity [$ms^{-1}$]', 'Interpreter', 'latex');
    title('Z velocity vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    %% ECEF state
    
    % Switch figure

    tabii = tabii + 1;
    axes('Parent', tabs{tabii});

    % Plot

    % X coordinate

    subplot(2, 3, 1);

    hold on;

    plot( ... 
        simTime, ... 
        posEcef(1, :), ... 
        'b', ... 
        'LineWidth', 2);

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('X coordinate [m]', 'Interpreter', 'latex');
    title('X coordinate vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    % Y coordinate

    subplot(2, 3, 2);

    hold on;

    plot( ... 
        simTime, ... 
        posEcef(2, :), ... 
        'b', ... 
        'LineWidth', 2);

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('Y coordinate [m]', 'Interpreter', 'latex');
    title('Y coordinate vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    % Z coordinate

    subplot(2, 3, 3);

    hold on;

    plot( ... 
        simTime, ... 
        posEcef(3, :), ... 
        'b', ... 
        'LineWidth', 2);

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('Z coordinate [m]', 'Interpreter', 'latex');
    title('Z coordinate vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    % X velocity

    subplot(2, 3, 4);

    hold on;

    plot( ... 
        simTime, ... 
        velEcef(1, :), ... 
        'b', ... 
        'LineWidth', 2);

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('X velocity [$ms^{-1}$]', 'Interpreter', 'latex');
    title('X velocity vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    % Y velocity

    subplot(2, 3, 5);

    hold on;

    plot( ... 
        simTime, ... 
        velEcef(2, :), ... 
        'b', ... 
        'LineWidth', 2);

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('Y velocity [$ms^{-1}$]', 'Interpreter', 'latex');
    title('Y velocity vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    % Z velocity

    subplot(2, 3, 6);

    hold on;

    plot( ... 
        simTime, ... 
        velEcef(3, :), ... 
        'b', ... 
        'LineWidth', 2);

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('Z velocity [$ms^{-1}$]', 'Interpreter', 'latex');
    title('Z velocity vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    %% Ground track

    % Switch figure

    tabii = tabii + 1;
    axes('Parent', tabs{tabii});

    % Plot

    geoplot( ... 
        posLLA(1, :) .* (180 / pi), ... 
        posLLA(2, :) .* (180 / pi), ... 
        'Color', 'b', ... 
        'LineWidth', 2);

    title('Ground track', 'Interpreter', 'latex');

    geobasemap streets-dark

    %% 3D trajectory
    
    % Switch figure

    tabii = tabii + 1;
    axes('Parent', tabs{tabii});

    % Plot

    % Sphere object

    [Xsph, Ysph, Zsph] = sphere(50);  % 50 controls resolution
    Xsph = Xsph .* simData.cts.rCelBod;
    Ysph = Ysph .* simData.cts.rCelBod;
    Zsph = Zsph .* simData.cts.rCelBod;

    hold on;

    surf( ... 
        Xsph, ... 
        Ysph, ... 
        Zsph, ... 
        'EdgeColor', 'b', ... 
        'FaceColor', 'b', ... 
        'DisplayName', 'Earth');

    plot3( ... 
        posEci(1, :), ... 
        posEci(2, :), ... 
        posEci(3, :), ... 
        'r', ... 
        'LineWidth', 2, ... 
        'DisplayName', 'ECI');

    plot3( ... 
        posEcef(1, :), ... 
        posEcef(2, :), ... 
        posEcef(3, :), ... 
        'g', ... 
        'LineWidth', 2, ... 
        'DisplayName', 'ECEF');

    xlabel('X coordinate [m]', 'Interpreter', 'latex');
    ylabel('Y coordinate [m]', 'Interpreter', 'latex');
    zlabel('Z coordinate [m]', 'Interpreter', 'latex');
    title('3D trajectory', 'Interpreter', 'latex');

    grid on;
    grid minor;

    axis equal;

    hold off;

    legend('Interpreter', 'latex');

    %% Attitude
    
    % Switch figure

    tabii = tabii + 1;
    axes('Parent', tabs{tabii});

    % Calculate Euler angles

    q0 = convertQuatConv(attEci2Bod', 0) ; % Switch to q0 convention
    eulerAngles = quat2eul(q0, "ZYX");
    eulerAngles = eulerAngles'; % Stack by columns (quat2eul takes stacked by columns)

    % Plot

    % Roll

    subplot(3, 1, 1);

    hold on;

    plot( ... 
        simTime, ... 
        eulerAngles(1, :) .* (180 / pi), ... 
        'b', ... 
        'LineWidth', 2);

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('Roll [$^{\circ }$]', 'Interpreter', 'latex');
    title('Roll angle vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    % Pitch

    subplot(3, 1, 2);

    hold on;

    plot( ... 
        simTime, ... 
        eulerAngles(2, :) .* (180 / pi), ... 
        'b', ... 
        'LineWidth', 2);

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('Pitch [$^{\circ }$]', 'Interpreter', 'latex');
    title('Pitch angle vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    % Yaw

    subplot(3, 1, 3);

    hold on;

    plot( ... 
        simTime, ... 
        eulerAngles(3, :) .* (180 / pi), ... 
        'b', ... 
        'LineWidth', 2);

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('Yaw [$^{\circ }$]', 'Interpreter', 'latex');
    title('Yaw angle vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    %% Angular velocities
    
    % Switch figure

    tabii = tabii + 1;
    axes('Parent', tabs{tabii});
    
    % Plot

    % X angular velocity

    subplot(3, 1, 1);

    hold on;

    plot( ... 
        simTime, ... 
        omgBod(1, :) .* (180 / pi), ... 
        'b', ... 
        'LineWidth', 2);

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('X angular velocity [$^{\circ }s^{-1}$]', 'Interpreter', 'latex');
    title('X angular velocity vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    % Y angular velocity

    subplot(3, 1, 2);

    hold on;

    plot( ... 
        simTime, ... 
        omgBod(2, :) .* (180 / pi), ... 
        'b', ... 
        'LineWidth', 2);

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('Y angular velocity [$^{\circ }s^{-1}$]', 'Interpreter', 'latex');
    title('Y angular velocity vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    % Z angular velocity

    subplot(3, 1, 3);

    hold on;

    plot( ... 
        simTime, ... 
        omgBod(3, :) .* (180 / pi), ... 
        'b', ... 
        'LineWidth', 2);

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('Z angular velocity [$^{\circ }s^{-1}$]', 'Interpreter', 'latex');
    title('Z angular velocity vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    %% Mass properties
    
    % Switch figure

    tabii = tabii + 1;
    axes('Parent', tabs{tabii});

    % Plot

    % Total mass

    subplot(3, 1, 1);

    hold on;

    plot( ... 
        simTime, ... 
        totMass, ... 
        'b', ... 
        'LineWidth', 2);

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('Total mass [kg]', 'Interpreter', 'latex');
    title('Total mass vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;
    
    % Fuel mass

    subplot(3, 1, 2);

    hold on;

    plot( ... 
        simTime, ... 
        fuelMass, ... 
        'b', ... 
        'LineWidth', 2);

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('Fuel mass [kg]', 'Interpreter', 'latex');
    title('Fuel mass vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;
    
    % Inertia tensor

    subplot(3, 1, 3);

    hold on;

    plot( ... 
        simTime, ... 
        squeeze(inertia(1, 1, :)), ... 
        'm', ... 
        'LineWidth', 3, ... 
        'DisplayName', '$I_{xx}$');

    plot( ... 
        simTime, ... 
        squeeze(inertia(2, 2, :)), ... 
        'c', ... 
        'LineWidth', 2, ... 
        'DisplayName', '$I_{yy}$');

    plot( ... 
        simTime, ... 
        squeeze(inertia(3, 3, :)), ... 
        'y', ... 
        'LineWidth', 1, ... 
        'DisplayName', '$I_{zz}$');

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('Inertia moment [$kgm^{2}$]', 'Interpreter', 'latex');
    title('Inertia vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    legend('Interpreter', 'latex');

end







end