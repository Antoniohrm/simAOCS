%
% Postpro of the navigation function
%

function [] = postpro_navigation(resName)

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
    'posEciNav', ... 
    'velEciNav', ... 
    'qEci2BodNav', ... 
    'omgBodNav', ... 
    'posEci', ... 
    'velEci', ... 
    'attEci2Bod', ... 
    'omgBod', ... 
    'gncMode'};

%% Initialize figure

fig = figure('Name', 'Navigation postpro');

tabNames = { ... 
    'ECI position', ... 
    'ECI velocity', ... 
    'ECI2BODY attitude', ... 
    'Body angular velocity'};

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

    %% Index of the instants in which the fine navigation is being executed

    idFine = find(gncMode == 2 | gncMode == 3);

    if isempty(idFine)
        idFine = 1:length(simTime);
        noFineIds = true;
    else
        noFineIds = false;
    end

    %% ECI position
    
    % Switch figure

    tabii = tabii + 1;
    axes('Parent', tabs{tabii});

    % Plot

    if ~noFineIds
    
        % ECI X coordinate
    
        subplot(3, 2, 1);
    
        hold on;
    
        plot( ... 
            simTime, ... 
            posEciNav(1, :), ... 
            'Color', 'g', ... 
            'LineStyle', '-', ... 
            'LineWidth', 1.5, ... 
            'DisplayName', 'Navigation');
    
        plot( ... 
            simTime, ... 
            posEci(1, :), ... 
            'Color', 'r', ... 
            'LineStyle', ':', ... 
            'LineWidth', 3.5, ... 
            'DisplayName', 'Real');
    
        xlabel('Time [s]', 'Interpreter', 'latex');
        ylabel('$X _{ECI}$ [m]', 'Interpreter', 'latex');
        title('ECI X coordinate vs time', 'Interpreter', 'latex');
    
        grid on;
        grid minor;
    
        hold off;
    
        legend('Interpreter', 'latex');
    
        % ECI X coordinate navigation error
    
        subplot(3, 2, 2);
    
        hold on;
    
        plot( ... 
            simTime, ... 
            abs(posEciNav(1, :) - posEci(1, :)), ... 
            'Color', 'b', ... 
            'LineStyle', '-', ... 
            'LineWidth', 2);
        
        % Set axes range to display the error only when the fine navigation is 
        % running
        ylim( ... 
            [min(abs(posEciNav(1, idFine) - posEci(1, idFine))), ... 
            max(abs(posEciNav(1, idFine) - posEci(1, idFine)))]);
    
        xlabel('Time [s]', 'Interpreter', 'latex');
        ylabel('$\Delta X _{ECI}$ [m]', 'Interpreter', 'latex');
        title('ECI X coordinate navigation error vs time', 'Interpreter', 'latex');
    
        grid on;
        grid minor;
    
        hold off;
    
        % ECI Y coordinate
    
        subplot(3, 2, 3);
    
        hold on;
    
        plot( ... 
            simTime, ... 
            posEciNav(2, :), ... 
            'Color', 'g', ... 
            'LineStyle', '-', ... 
            'LineWidth', 1.5, ... 
            'DisplayName', 'Navigation');
    
        plot( ... 
            simTime, ... 
            posEci(2, :), ... 
            'Color', 'r', ... 
            'LineStyle', ':', ... 
            'LineWidth', 3.5, ... 
            'DisplayName', 'Real');
    
        xlabel('Time [s]', 'Interpreter', 'latex');
        ylabel('$Y _{ECI}$ [m]', 'Interpreter', 'latex');
        title('ECI Y coordinate vs time', 'Interpreter', 'latex');
    
        grid on;
        grid minor;
    
        hold off;
    
        legend('Interpreter', 'latex');
    
        % ECI Y coordinate navigation error
    
        subplot(3, 2, 4);
    
        hold on;
    
        plot( ... 
            simTime, ... 
            abs(posEciNav(2, :) - posEci(2, :)), ... 
            'Color', 'b', ... 
            'LineStyle', '-', ... 
            'LineWidth', 2);
    
        % Set axes range to display the error only when the fine navigation is 
        % running
        ylim( ... 
            [min(abs(posEciNav(2, idFine) - posEci(2, idFine))), ... 
            max(abs(posEciNav(2, idFine) - posEci(2, idFine)))]);
    
        xlabel('Time [s]', 'Interpreter', 'latex');
        ylabel('$\Delta Y _{ECI}$ [m]', 'Interpreter', 'latex');
        title('ECI Y coordinate navigation error vs time', 'Interpreter', 'latex');
    
        grid on;
        grid minor;
    
        hold off;
    
        % ECI Z coordinate
    
        subplot(3, 2, 5);
    
        hold on;
    
        plot( ... 
            simTime, ... 
            posEciNav(3, :), ... 
            'Color', 'g', ... 
            'LineStyle', '-', ... 
            'LineWidth', 1.5, ... 
            'DisplayName', 'Navigation');
    
        plot( ... 
            simTime, ... 
            posEci(3, :), ... 
            'Color', 'r', ... 
            'LineStyle', ':', ... 
            'LineWidth', 3.5, ... 
            'DisplayName', 'Real');
    
        xlabel('Time [s]', 'Interpreter', 'latex');
        ylabel('$Z _{ECI}$ [m]', 'Interpreter', 'latex');
        title('ECI Z coordinate vs time', 'Interpreter', 'latex');
    
        grid on;
        grid minor;
    
        hold off;
    
        legend('Interpreter', 'latex');
    
        % ECI Z coordinate navigation error
    
        subplot(3, 2, 6);
    
        hold on;
    
        plot( ... 
            simTime, ... 
            abs(posEciNav(3, :) - posEci(3, :)), ... 
            'Color', 'b', ... 
            'LineStyle', '-', ... 
            'LineWidth', 2);
    
        % Set axes range to display the error only when the fine navigation is 
        % running
        ylim( ... 
            [min(abs(posEciNav(3, idFine) - posEci(3, idFine))), ... 
            max(abs(posEciNav(3, idFine) - posEci(3, idFine)))]);
    
        xlabel('Time [s]', 'Interpreter', 'latex');
        ylabel('$\Delta Z _{ECI}$ [m]', 'Interpreter', 'latex');
        title('ECI Z coordinate navigation error vs time', 'Interpreter', 'latex');
    
        grid on;
        grid minor;
    
        hold off;

    end

    %% ECI velocity
    
    % Switch figure

    tabii = tabii + 1;
    axes('Parent', tabs{tabii});

    % Plot

    if ~noFineIds
    
        % ECI X velocity
    
        subplot(3, 2, 1);
    
        hold on;
    
        plot( ... 
            simTime, ... 
            velEciNav(1, :), ... 
            'Color', 'g', ... 
            'LineStyle', '-', ... 
            'LineWidth', 1.5, ... 
            'DisplayName', 'Navigation');
    
        plot( ... 
            simTime, ... 
            velEci(1, :), ... 
            'Color', 'r', ... 
            'LineStyle', ':', ... 
            'LineWidth', 3.5, ... 
            'DisplayName', 'Real');
    
        xlabel('Time [s]', 'Interpreter', 'latex');
        ylabel('$\dot{X} _{ECI}$ [$ms^{-1}$]', 'Interpreter', 'latex');
        title('ECI X velocity vs time', 'Interpreter', 'latex');
    
        grid on;
        grid minor;
    
        hold off;
    
        legend('Interpreter', 'latex');
    
        % ECI X velocity navigation error
    
        subplot(3, 2, 2);
    
        hold on;
    
        plot( ... 
            simTime, ... 
            abs(velEciNav(1, :) - velEci(1, :)), ... 
            'Color', 'b', ... 
            'LineStyle', '-', ... 
            'LineWidth', 2);
    
        % Set axes range to display the error only when the fine navigation is 
        % running
        ylim( ... 
            [min(abs(velEciNav(1, idFine) - velEci(1, idFine))), ... 
            max(abs(velEciNav(1, idFine) - velEci(1, idFine)))]);
    
        xlabel('Time [s]', 'Interpreter', 'latex');
        ylabel('$\Delta \dot{X} _{ECI}$ [$ms^{-1}$]', 'Interpreter', 'latex');
        title('ECI X velocity navigation error vs time', 'Interpreter', 'latex');
    
        grid on;
        grid minor;
    
        hold off;
    
        % ECI Y velocity
    
        subplot(3, 2, 3);
    
        hold on;
    
        plot( ... 
            simTime, ... 
            velEciNav(2, :), ... 
            'Color', 'g', ... 
            'LineStyle', '-', ... 
            'LineWidth', 1.5, ... 
            'DisplayName', 'Navigation');
    
        plot( ... 
            simTime, ... 
            velEci(2, :), ... 
            'Color', 'r', ... 
            'LineStyle', ':', ... 
            'LineWidth', 3.5, ... 
            'DisplayName', 'Real');
    
        xlabel('Time [s]', 'Interpreter', 'latex');
        ylabel('$\dot{Y} _{ECI}$ [$ms^{-1}$]', 'Interpreter', 'latex');
        title('ECI Y velocity vs time', 'Interpreter', 'latex');
    
        grid on;
        grid minor;
    
        hold off;
    
        legend('Interpreter', 'latex');
    
        % ECI Y velocity navigation error
    
        subplot(3, 2, 4);
    
        hold on;
    
        plot( ... 
            simTime, ... 
            abs(velEciNav(2, :) - velEci(2, :)), ... 
            'Color', 'b', ... 
            'LineStyle', '-', ... 
            'LineWidth', 2);
    
        % Set axes range to display the error only when the fine navigation is 
        % running
        ylim( ... 
            [min(abs(velEciNav(2, idFine) - velEci(2, idFine))), ... 
            max(abs(velEciNav(2, idFine) - velEci(2, idFine)))]);
    
        xlabel('Time [s]', 'Interpreter', 'latex');
        ylabel('$\Delta \dot{Y} _{ECI}$ [$ms^{-1}$]', 'Interpreter', 'latex');
        title('ECI Y velocity navigation error vs time', 'Interpreter', 'latex');
    
        grid on;
        grid minor;
    
        hold off;
    
        % ECI Z velocity
    
        subplot(3, 2, 5);
    
        hold on;
    
        plot( ... 
            simTime, ... 
            velEciNav(3, :), ... 
            'Color', 'g', ... 
            'LineStyle', '-', ... 
            'LineWidth', 1.5, ... 
            'DisplayName', 'Navigation');
    
        plot( ... 
            simTime, ... 
            velEci(3, :), ... 
            'Color', 'r', ... 
            'LineStyle', ':', ... 
            'LineWidth', 3.5, ... 
            'DisplayName', 'Real');
    
        xlabel('Time [s]', 'Interpreter', 'latex');
        ylabel('$\dot{Z} _{ECI}$ [$ms^{-1}$]', 'Interpreter', 'latex');
        title('ECI Z velocity vs time', 'Interpreter', 'latex');
    
        grid on;
        grid minor;
    
        hold off;
    
        legend('Interpreter', 'latex');
    
        % ECI Z velocity navigation error
    
        subplot(3, 2, 6);
    
        hold on;
    
        plot( ... 
            simTime, ... 
            abs(velEciNav(3, :) - velEci(3, :)), ... 
            'Color', 'b', ... 
            'LineStyle', '-', ... 
            'LineWidth', 2);
    
        % Set axes range to display the error only when the fine navigation is 
        % running
        ylim( ... 
            [min(abs(velEciNav(3, idFine) - velEci(3, idFine))), ... 
            max(abs(velEciNav(3, idFine) - velEci(3, idFine)))]);
    
        xlabel('Time [s]', 'Interpreter', 'latex');
        ylabel('$\Delta \dot{Z} _{ECI}$ [$ms^{-1}$]', 'Interpreter', 'latex');
        title('ECI Z velocity navigation error vs time', 'Interpreter', 'latex');
    
        grid on;
        grid minor;
    
        hold off;

    end

    %% ECI2BODY attitude
    
    % Switch figure

    tabii = tabii + 1;
    axes('Parent', tabs{tabii});
    
    % Calculate Euler angles

    q0 = convertQuatConv(attEci2Bod', 0) ; % Switch to q0 convention
    eulerAngles = quat2eul(q0, "ZYX");
    eulerAngles = eulerAngles'; % Stack by columns (quat2eul takes stacked by columns)

    q0Nav = convertQuatConv(qEci2BodNav', 0) ; % Switch to q0 convention
    eulerAnglesNav = quat2eul(q0Nav, "ZYX");
    eulerAnglesNav = eulerAnglesNav'; % Stack by columns (quat2eul takes stacked by columns)

    % Plot

    if ~noFineIds
    
        % Roll
    
        subplot(3, 2, 1);
    
        hold on;
    
        plot( ... 
            simTime(idFine), ... 
            eulerAnglesNav(1, idFine) .* (180 / pi), ... 
            'Color', 'g', ... 
            'LineStyle', '-', ... 
            'LineWidth', 1.5, ... 
            'DisplayName', 'Navigation');
    
        plot( ... 
            simTime(idFine), ... 
            eulerAngles(1, idFine) .* (180 / pi), ... 
            'Color', 'r', ... 
            'LineStyle', ':', ... 
            'LineWidth', 3.5, ... 
            'DisplayName', 'Real');

        xlim([min(simTime), max(simTime)]);
    
        xlabel('Time [s]', 'Interpreter', 'latex');
        ylabel('$\phi $ [$^{\circ }$]', 'Interpreter', 'latex');
        title('Roll angle vs time', 'Interpreter', 'latex');
    
        grid on;
        grid minor;
    
        hold off;
    
        legend('Interpreter', 'latex');
    
        % Roll navigation error
    
        % Compute error & statistics
    
        angErr = ... 
            (eulerAngles(1, idFine) - ... 
            eulerAnglesNav(1, idFine)) .* ... 
            (180 / pi) .* 3600; % ['']

        [angErrNO, ~] = rmoutliers(angErr);
    
        errLeg = sprintf( ... 
            "$\\bar{\\Delta \\phi}$: %5.3f '', $\\sigma _{\\Delta \\phi}$: %5.3f ''", ... 
            mean(angErrNO), ... 
            std(angErrNO));
    
        subplot(3, 2, 2);
    
        hold on;
    
        plot( ... 
            simTime(idFine), ... 
            (eulerAngles(1, idFine) - eulerAnglesNav(1, idFine)) .* (180 / pi), ... 
            'Color', 'b', ... 
            'LineStyle', '-', ... 
            'LineWidth', 2, ... 
            'DisplayName', errLeg);

        xlim([min(simTime), max(simTime)]);
    
        % Set axes range to display the error only when the fine navigation is 
        % running
        ylim([min(angErr ./ 3600), max(angErr ./ 3600)]);
    
        xlabel('Time [s]', 'Interpreter', 'latex');
        ylabel('$\Delta \phi $ [$^{\circ }$]', 'Interpreter', 'latex');
        title('Roll angle navigation error vs time', 'Interpreter', 'latex');
    
        grid on;
        grid minor;
    
        hold off;
    
        legend('Interpreter', 'latex');
        
        % Pitch
    
        subplot(3, 2, 3);
    
        hold on;
    
        plot( ... 
            simTime(idFine), ... 
            eulerAnglesNav(2, idFine) .* (180 / pi), ... 
            'Color', 'g', ... 
            'LineStyle', '-', ... 
            'LineWidth', 1.5, ... 
            'DisplayName', 'Navigation');
    
        plot( ... 
            simTime(idFine), ... 
            eulerAngles(2, idFine) .* (180 / pi), ... 
            'Color', 'r', ... 
            'LineStyle', ':', ... 
            'LineWidth', 3.5, ... 
            'DisplayName', 'Real');

        xlim([min(simTime), max(simTime)]);
    
        xlabel('Time [s]', 'Interpreter', 'latex');
        ylabel('$\theta $ [$^{\circ }$]', 'Interpreter', 'latex');
        title('Pitch angle vs time', 'Interpreter', 'latex');
    
        grid on;
        grid minor;
    
        hold off;
    
        legend('Interpreter', 'latex');
    
        % Pitch navigation error
    
        % Compute error & statistics
    
        angErr = ... 
            (eulerAngles(2, idFine) - ... 
            eulerAnglesNav(2, idFine)) .* ... 
            (180 / pi) .* 3600; % ['']

        [angErrNO, ~] = rmoutliers(angErr);
    
        errLeg = sprintf( ... 
            "$\\bar{\\Delta \\theta}$: %5.3f '', $\\sigma _{\\Delta \\theta}$: %5.3f ''", ... 
            mean(angErrNO), ... 
            std(angErrNO));
    
        subplot(3, 2, 4);
    
        hold on;
    
        plot( ... 
            simTime(idFine), ... 
            (eulerAngles(2, idFine) - eulerAnglesNav(2, idFine)) .* (180 / pi), ... 
            'Color', 'b', ... 
            'LineStyle', '-', ... 
            'LineWidth', 2, ... 
            'DisplayName', errLeg);

        xlim([min(simTime), max(simTime)]);
    
        % Set axes range to display the error only when the fine navigation is 
        % running
        ylim([min(angErr ./ 3600), max(angErr ./ 3600)]);
    
        xlabel('Time [s]', 'Interpreter', 'latex');
        ylabel('$\Delta \theta $ [$^{\circ }$]', 'Interpreter', 'latex');
        title('Pitch angle navigation error vs time', 'Interpreter', 'latex');
    
        grid on;
        grid minor;
    
        hold off;
    
        legend('Interpreter', 'latex');
    
        % Yaw
    
        subplot(3, 2, 5);
    
        hold on;
    
        plot( ... 
            simTime(idFine), ... 
            eulerAnglesNav(3, idFine) .* (180 / pi), ... 
            'Color', 'g', ... 
            'LineStyle', '-', ... 
            'LineWidth', 1.5, ... 
            'DisplayName', 'Navigation');
    
        plot( ... 
            simTime(idFine), ... 
            eulerAngles(3, idFine) .* (180 / pi), ... 
            'Color', 'r', ... 
            'LineStyle', ':', ... 
            'LineWidth', 3.5, ... 
            'DisplayName', 'Real');

        xlim([min(simTime), max(simTime)]);
    
        xlabel('Time [s]', 'Interpreter', 'latex');
        ylabel('$\psi $ [$^{\circ }$]', 'Interpreter', 'latex');
        title('Yaw angle vs time', 'Interpreter', 'latex');
    
        grid on;
        grid minor;
    
        hold off;
    
        legend('Interpreter', 'latex');
    
        % Yaw navigation error
    
        % Compute error & statistics
    
        angErr = ... 
            (eulerAngles(3, idFine) - ... 
            eulerAnglesNav(3, idFine)) .* ... 
            (180 / pi) .* 3600; % ['']

        [angErrNO, ~] = rmoutliers(angErr);
    
        errLeg = sprintf( ... 
            "$\\bar{\\Delta \\psi}$: %5.3f '', $\\sigma _{\\Delta \\psi}$: %5.3f ''", ... 
            mean(angErrNO), ... 
            std(angErrNO));
    
        subplot(3, 2, 6);
    
        hold on;
    
        plot( ... 
            simTime(idFine), ... 
            (eulerAngles(3, idFine) - eulerAnglesNav(3, idFine)) .* (180 / pi), ... 
            'Color', 'b', ... 
            'LineStyle', '-', ... 
            'LineWidth', 2, ... 
            'DisplayName', errLeg);

        xlim([min(simTime), max(simTime)]);
    
        % Set axes range to display the error only when the fine navigation is 
        % running
        ylim([min(angErr ./ 3600), max(angErr ./ 3600)]);
    
        xlabel('Time [s]', 'Interpreter', 'latex');
        ylabel('$\Delta \psi$ [$^{\circ }$]', 'Interpreter', 'latex');
        title('Yaw angle navigation error vs time', 'Interpreter', 'latex');
    
        grid on;
        grid minor;
    
        hold off;
    
        legend('Interpreter', 'latex');

    end

    %% BODY2ECI angular velocity
    
    % Switch figure

    tabii = tabii + 1;
    axes('Parent', tabs{tabii});

    % Plot
    
    % X angular velocity

    subplot(3, 2, 1);

    hold on;

    plot( ... 
        simTime, ... 
        omgBodNav(1, :) .* (180 / pi), ... 
        'Color', 'g', ... 
        'LineStyle', '-', ... 
        'LineWidth', 1.5, ... 
        'DisplayName', 'Navigation');

    plot( ... 
        simTime, ... 
        omgBod(1, :) .* (180 / pi), ... 
        'Color', 'r', ... 
        'LineStyle', ':', ... 
        'LineWidth', 3.5, ... 
        'DisplayName', 'Real');

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('$\omega _{X}$ [$^{\circ }s^{-1}$]', 'Interpreter', 'latex');
    title('X angular velocity vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    legend('Interpreter', 'latex');

    % X angular velocity navigation error

    % Compute error & statistics

    omgErr = ... 
        (omgBod(1, idFine) - ... 
        omgBodNav(1, idFine)) .* ... 
        (180 / pi); % [ºs-1]

    errLeg = sprintf( ... 
        "$\\bar{\\Delta \\omega _{X}}$: %5.3f $^{\\circ } s^{-1}$, $\\sigma _{\\Delta \\omega _{X}}$: %5.3f $^{\\circ } s^{-1}$", ... 
        mean(omgErr), ... 
        std(omgErr));

    subplot(3, 2, 2);

    hold on;

    plot( ... 
        simTime, ... 
        (omgBod(1, :) - omgBodNav(1, :)) .* (180 / pi), ... 
        'Color', 'b', ... 
        'LineStyle', '-', ... 
        'LineWidth', 2, ... 
        'DisplayName', errLeg);

    % Set axes range to display the error only when the fine navigation is 
    % running
    ylim( ... 
        [min(abs(omgBodNav(1, idFine) - omgBod(1, idFine))), ... 
        max(abs(omgBodNav(1, idFine) - omgBod(1, idFine)))]);

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('$\Delta \omega _{X}$ [$^{\circ }s^{-1}$]', 'Interpreter', 'latex');
    title('X angular velocity navigation error vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    legend('Interpreter', 'latex');

    % Y angular velocity

    subplot(3, 2, 3);

    hold on;

    plot( ... 
        simTime, ... 
        omgBodNav(2, :) .* (180 / pi), ... 
        'Color', 'g', ... 
        'LineStyle', '-', ... 
        'LineWidth', 1.5, ... 
        'DisplayName', 'Navigation');

    plot( ... 
        simTime, ... 
        omgBod(2, :) .* (180 / pi), ... 
        'Color', 'r', ... 
        'LineStyle', ':', ... 
        'LineWidth', 3.5, ... 
        'DisplayName', 'Real');

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('$\omega _{Y}$ [$^{\circ }s^{-1}$]', 'Interpreter', 'latex');
    title('Y angular velocity vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    legend('Interpreter', 'latex');

    % Y angular velocity navigation error

    % Compute error & statistics

    omgErr = ... 
        (omgBod(2, idFine) - ... 
        omgBodNav(2, idFine)) .* ... 
        (180 / pi); % [ºs-1]

    errLeg = sprintf( ... 
        "$\\bar{\\Delta \\omega _{Y}}$: %5.3f $^{\\circ } s^{-1}$, $\\sigma _{\\Delta \\omega _{Y}}$: %5.3f $^{\\circ } s^{-1}$", ... 
        mean(omgErr), ... 
        std(omgErr));

    subplot(3, 2, 4);

    hold on;

    plot( ... 
        simTime, ... 
        abs(omgBod(2, :) - omgBodNav(2, :)) .* (180 / pi), ... 
        'Color', 'b', ... 
        'LineStyle', '-', ... 
        'LineWidth', 2, ... 
        'DisplayName', errLeg);

    % Set axes range to display the error only when the fine navigation is 
    % running
    ylim( ... 
        [min(abs(omgBodNav(2, idFine) - omgBod(2, idFine))), ... 
        max(abs(omgBodNav(2, idFine) - omgBod(2, idFine)))]);

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('$\Delta \omega _{Y}$ [$^{\circ }s^{-1}$]', 'Interpreter', 'latex');
    title('Y angular velocity navigation error vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    legend('Interpreter', 'latex');

    % Z angular velocity

    subplot(3, 2, 5);

    hold on;

    plot( ... 
        simTime, ... 
        omgBodNav(3, :) .* (180 / pi), ... 
        'Color', 'g', ... 
        'LineStyle', '-', ... 
        'LineWidth', 1.5, ... 
        'DisplayName', 'Navigation');

    plot( ... 
        simTime, ... 
        omgBod(3, :) .* (180 / pi), ... 
        'Color', 'r', ... 
        'LineStyle', ':', ... 
        'LineWidth', 3.5, ... 
        'DisplayName', 'Real');

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('$\omega _{Z}$ [$^{\circ }s^{-1}$]', 'Interpreter', 'latex');
    title('Z angular velocity vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    legend('Interpreter', 'latex');

    % Z angular velocity navigation error

    % Compute error & statistics

    omgErr = ... 
        (omgBod(3, idFine) - ... 
        omgBodNav(3, idFine)) .* ... 
        (180 / pi); % [ºs-1]

    errLeg = sprintf( ... 
        "$\\bar{\\Delta \\omega _{Z}}$: %5.3f $^{\\circ } s^{-1}$, $\\sigma _{\\Delta \\omega _{Z}}$: %5.3f $^{\\circ } s^{-1}$", ... 
        mean(omgErr), ... 
        std(omgErr));

    subplot(3, 2, 6);

    hold on;

    plot( ... 
        simTime, ... 
        abs(omgBod(3, :) - omgBodNav(3, :)) .* (180 / pi), ... 
        'Color', 'b', ... 
        'LineStyle', '-', ... 
        'LineWidth', 2, ... 
        'DisplayName', errLeg);

    % Set axes range to display the error only when the fine navigation is 
    % running
    ylim( ... 
        [min(abs(omgBodNav(3, idFine) - omgBod(3, idFine))), ... 
        max(abs(omgBodNav(3, idFine) - omgBod(3, idFine)))]);

    xlabel('Time [s]', 'Interpreter', 'latex');
    ylabel('$\Delta \omega _{Z}$ [$^{\circ }s^{-1}$]', 'Interpreter', 'latex');
    title('Z angular velocity navigation error vs time', 'Interpreter', 'latex');

    grid on;
    grid minor;

    hold off;

    legend('Interpreter', 'latex');

    



end

end