%
% Postpro of the sensor measurements
%

function [] = postpro_sensors(resName)

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
    'omgBodGYR', ... 
    'magFieldBodMAG', ... 
    'qEci2BodSTR', ... 
    'llaGNSS', ... 
    'velNedGNSS', ... 
    'vMagGNSS', ... 
    'hdgGNSS', ... 
    'attEci2Bod', ... 
    'omgBod', ... 
    'posEcef', ...
    'velEcef', ... 
    'posLLA', ... 
    'magFieldEci'};

%% Initialize figure

fig = figure('Name', 'Sensors postpro');

tabNames = { ... 
    'Gyroscope', ... 
    'Magnetometer', ... 
    'Star tracker', ... 
    'GNSS'};

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

    %% Gyroscope
    
    % Switch figure

    tabii = tabii + 1;
    axes('Parent', tabs{tabii});

    % Plot
    
    % Body angular velocity around X axis

    subplot(3, 2, 1);

    hold on;

    plot( ... 
        simTime, ... 
        omgBod(1, :) .* (180 / pi), ... 
        'Color', 'r', ... 
        'LineStyle', ':', ... 
        'LineWidth', 3.5, ... 
        'DisplayName', 'Real');

    plot( ... 
        simTime, ... 
        omgBodGYR(1, :) .* (180 / pi), ... 
        'Color', 'g', ... 
        'LineStyle', '-', ... 
        'LineWidth', 1.5, ... 
        'DisplayName', 'Measured');

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('$\omega _{X}$ [$^{\circ}s^{-1}$]', 'Interpreter', 'latex');
    title('Satellite angular velocity vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    legend('Interpreter', 'latex');

    % Body angular velocity measurement error around X axis

    subplot(3, 2, 2);

    hold on;

    plot( ... 
        simTime, ... 
        abs(omgBod(1, :) - omgBodGYR(1, :)) .* (180 / pi), ... 
        'Color', 'b', ... 
        'LineStyle', '-', ... 
        'LineWidth', 2);

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('$\Delta \omega _{X}$ [$^{\circ}s^{-1}$]', 'Interpreter', 'latex');
    title('Satellite angular velocity measurement error vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    % Body angular velocity around Y axis

    subplot(3, 2, 3);

    hold on;

    plot( ... 
        simTime, ... 
        omgBod(2, :) .* (180 / pi), ... 
        'Color', 'r', ... 
        'LineStyle', ':', ... 
        'LineWidth', 3.5, ... 
        'DisplayName', 'Real');

    plot( ... 
        simTime, ... 
        omgBodGYR(2, :) .* (180 / pi), ... 
        'Color', 'g', ... 
        'LineStyle', '-', ... 
        'LineWidth', 1.5, ... 
        'DisplayName', 'Measured');

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('$\omega _{Y}$ [$^{\circ}s^{-1}$]', 'Interpreter', 'latex');
    title('Satellite angular velocity vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    legend('Interpreter', 'latex');

    % Body angular velocity measurement error around Y axis

    subplot(3, 2, 4);

    hold on;

    plot( ... 
        simTime, ... 
        abs(omgBod(2, :) - omgBodGYR(2, :)) .* (180 / pi), ... 
        'Color', 'b', ... 
        'LineStyle', '-', ... 
        'LineWidth', 2);

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('$\Delta \omega _{Y}$ [$^{\circ}s^{-1}$]', 'Interpreter', 'latex');
    title('Satellite angular velocity measurement error vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    % Body angular velocity around Z axis

    subplot(3, 2, 5);

    hold on;

    plot( ... 
        simTime, ... 
        omgBod(3, :) .* (180 / pi), ... 
        'Color', 'r', ... 
        'LineStyle', ':', ... 
        'LineWidth', 3.5, ... 
        'DisplayName', 'Real');

    plot( ... 
        simTime, ... 
        omgBodGYR(3, :) .* (180 / pi), ... 
        'Color', 'g', ... 
        'LineStyle', '-', ... 
        'LineWidth', 1.5, ... 
        'DisplayName', 'Measured');

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('$\omega _{Z}$ [$^{\circ}s^{-1}$]', 'Interpreter', 'latex');
    title('Satellite angular velocity vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    legend('Interpreter', 'latex');

    % Body angular velocity measurement error around Z axis

    subplot(3, 2, 6);

    hold on;

    plot( ... 
        simTime, ... 
        abs(omgBod(3, :) - omgBodGYR(3, :)) .* (180 / pi), ... 
        'Color', 'b', ... 
        'LineStyle', '-', ... 
        'LineWidth', 2);

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('$\Delta \omega _{Z}$ [$^{\circ}s^{-1}$]', 'Interpreter', 'latex');
    title('Satellite angular velocity measurement error vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    %% Magnetometer
    
    % Switch figure

    tabii = tabii + 1;
    axes('Parent', tabs{tabii});
    
    % Convert real magnetic field to Body frame
    
    q0 = convertQuatConv(attEci2Bod', 0, true); % Convert to q0 and stack by rows

    magFieldBod = quatrotate(q0, magFieldEci')';

    % Plot
    
    % Body magnetic field along X axis

    subplot(3, 2, 1);

    hold on;

    plot( ... 
        simTime, ... 
        magFieldBod(1, :), ... 
        'Color', 'r', ... 
        'LineStyle', ':', ... 
        'LineWidth', 3.5, ... 
        'DisplayName', 'Real');

    plot( ... 
        simTime, ... 
        magFieldBodMAG(1, :), ... 
        'Color', 'g', ... 
        'LineStyle', '-', ... 
        'LineWidth', 1.5, ... 
        'DisplayName', 'Measured');

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('$B _{X}$ [nT]', 'Interpreter', 'latex');
    title('Magnetic field in body frame vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    legend('Interpreter', 'latex');

    % Body magnetic field measurement error along X axis

    subplot(3, 2, 2);

    hold on;

    plot( ... 
        simTime, ... 
        abs(magFieldBod(1, :) - magFieldBodMAG(1, :)), ... 
        'Color', 'b', ... 
        'LineStyle', ':', ... 
        'LineWidth', 2);

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('$\Delta B _{X}$ [nT]', 'Interpreter', 'latex');
    title('Magnetic field measurement error in body frame vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    % Body magnetic field along Y axis

    subplot(3, 2, 3);

    hold on;

    plot( ... 
        simTime, ... 
        magFieldBod(2, :), ... 
        'Color', 'r', ... 
        'LineStyle', ':', ... 
        'LineWidth', 3.5, ... 
        'DisplayName', 'Real');

    plot( ... 
        simTime, ... 
        magFieldBodMAG(2, :), ... 
        'Color', 'g', ... 
        'LineStyle', '-', ... 
        'LineWidth', 1.5, ... 
        'DisplayName', 'Measured');

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('$B _{Y}$ [nT]', 'Interpreter', 'latex');
    title('Magnetic field in body frame vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    legend('Interpreter', 'latex');

    % Body magnetic field measurement error along Y axis

    subplot(3, 2, 4);

    hold on;

    plot( ... 
        simTime, ... 
        abs(magFieldBod(2, :) - magFieldBodMAG(2, :)), ... 
        'Color', 'b', ... 
        'LineStyle', ':', ... 
        'LineWidth', 2);

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('$\Delta B _{Y}$ [nT]', 'Interpreter', 'latex');
    title('Magnetic field measurement error in body frame vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    % Body magnetic field along Z axis

    subplot(3, 2, 5);

    hold on;

    plot( ... 
        simTime, ... 
        magFieldBod(3, :), ... 
        'Color', 'r', ... 
        'LineStyle', ':', ... 
        'LineWidth', 3.5, ... 
        'DisplayName', 'Real');

    plot( ... 
        simTime, ... 
        magFieldBodMAG(3, :), ... 
        'Color', 'g', ... 
        'LineStyle', '-', ... 
        'LineWidth', 1.5, ... 
        'DisplayName', 'Measured');

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('$B _{Z}$ [nT]', 'Interpreter', 'latex');
    title('Magnetic field in body frame vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    legend('Interpreter', 'latex');

    % Body magnetic field measurement error along Z axis

    subplot(3, 2, 6);

    hold on;

    plot( ... 
        simTime, ... 
        abs(magFieldBod(3, :) - magFieldBodMAG(3, :)), ... 
        'Color', 'b', ... 
        'LineStyle', ':', ... 
        'LineWidth', 2);

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('$\Delta B _{Z}$ [nT]', 'Interpreter', 'latex');
    title('Magnetic field measurement error in body frame vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    %% Star tracker
    
    % Switch figure

    tabii = tabii + 1;
    axes('Parent', tabs{tabii});

    % Plot
    
    % (Plot 1 description)

    %% GNSS
    
    % Switch figure

    tabii = tabii + 1;
    axes('Parent', tabs{tabii});

    % Convert LLA signals to degrees and km

    llaRealDegKm = [ ... 
        posLLA(1:2, :) .* (180 / pi); ... 
        posLLA(3, :) .* 1e-3];

    llaMeasDegKm = [ ... 
        llaGNSS(1:2, :) .* (180 / pi); ... 
        llaGNSS(3, :) .* 1e-3];

    % Plot
    
    % Latitude

    subplot(3, 4, 1);

    hold on;

    plot( ... 
        simTime, ... 
        llaRealDegKm(1, :), ... 
        'Color', 'r', ... 
        'LineStyle', ':', ... 
        'LineWidth', 3.5, ... 
        'DisplayName', 'Real');

    plot( ... 
        simTime, ... 
        llaMeasDegKm (1, :), ... 
        'Color', 'g', ... 
        'LineStyle', '-', ... 
        'LineWidth', 1.5, ... 
        'DisplayName', 'Measured');

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('Latitude [$^{\circ }$]', 'Interpreter', 'latex');
    title('Latitude vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    legend('Interpreter', 'latex');

    % Latitude measurement error

    subplot(3, 4, 2);

    hold on;

    plot( ... 
        simTime, ... 
        abs(llaMeasDegKm(1, :) - llaRealDegKm(1, :)), ... 
        'Color', 'b', ... 
        'LineStyle', ':', ... 
        'LineWidth', 2);

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('$\Delta $ Latitude [$^{\circ }$]', 'Interpreter', 'latex');
    title('Latitude measurement error vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    % Longitude

    subplot(3, 4, 5);

    hold on;

    plot( ... 
        simTime, ... 
        llaRealDegKm(2, :), ... 
        'Color', 'r', ... 
        'LineStyle', ':', ... 
        'LineWidth', 3.5, ... 
        'DisplayName', 'Real');

    plot( ... 
        simTime, ... 
        llaMeasDegKm (2, :), ... 
        'Color', 'g', ... 
        'LineStyle', '-', ... 
        'LineWidth', 1.5, ... 
        'DisplayName', 'Measured');

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('Longitude [$^{\circ }$]', 'Interpreter', 'latex');
    title('Longitude vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    legend('Interpreter', 'latex');

    % Longitude measurement error

    subplot(3, 4, 6);

    hold on;

    plot( ... 
        simTime, ... 
        abs(llaMeasDegKm(2, :) - llaRealDegKm(2, :)), ... 
        'Color', 'b', ... 
        'LineStyle', ':', ... 
        'LineWidth', 2);

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('$\Delta $ Longitude [$^{\circ }$]', 'Interpreter', 'latex');
    title('Longitude measurement error vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    % Altitude

    subplot(3, 4, 9);

    hold on;

    plot( ... 
        simTime, ... 
        llaRealDegKm(3, :), ... 
        'Color', 'r', ... 
        'LineStyle', ':', ... 
        'LineWidth', 3.5, ... 
        'DisplayName', 'Real');

    plot( ... 
        simTime, ... 
        llaMeasDegKm (3, :), ... 
        'Color', 'g', ... 
        'LineStyle', '-', ... 
        'LineWidth', 1.5, ... 
        'DisplayName', 'Measured');

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('Altitude [km]', 'Interpreter', 'latex');
    title('Altitude vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    legend('Interpreter', 'latex');

    % Altitude measurement error

    subplot(3, 4, 10);

    hold on;

    plot( ... 
        simTime, ... 
        abs(llaMeasDegKm(3, :) - llaRealDegKm(3, :)), ... 
        'Color', 'b', ... 
        'LineStyle', ':', ... 
        'LineWidth', 2);

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('$\Delta $ Altitude [km]', 'Interpreter', 'latex');
    title('Altitude measurement error vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    % Ground track
    
    subplot(3, 4, [3, 4, 7, 8, 11, 12]);

    geoplot( ... 
        llaRealDegKm(1, :), ... 
        llaRealDegKm(2, :), ... 
        'Color', 'r', ... 
        'LineStyle', ':', ... 
        'LineWidth', 3.5, ... 
        'DisplayName', 'Real');

    hold on;

    geoplot( ... 
        llaMeasDegKm(1, :), ... 
        llaMeasDegKm(2, :), ... 
        'Color', 'g', ... 
        'LineStyle', '-', ... 
        'LineWidth', 1.5, ... 
        'DisplayName', 'Measured');
    
    title('Ground track', 'Interpreter', 'latex');

    hold off;

    legend('Interpreter', 'latex');

    geobasemap streets-dark

end

end