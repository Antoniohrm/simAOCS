%
% This script containts the simulator input variables
%

%% Constants

celBod = 'Earth'; % Celestial body

% Earth

rCelBod = 6378e3; % Earth's equatorial radius [m]
muCelBod = 3.986e14; % Earth's gravitational parameter [m3s-2]
ellipsoidModelCelBod = 'WGS84'; % World Geodetic System 1984 ellipsoid model
omgCelBod = (2 * pi) / (24 * 3600); % Angular velocity of the Earth [rads-1]

timeRef = 'J2000'; % Time reference name

%% Initial conditions

% Initial instant (UTC)

initYear = 2025; % Year
initMonth = 1; % Month
initDay = 1; % Day
initHour = 12; % Hour
initMin = 0; % Minute
initSec = 0; % Second

% Definition types of the initial conditions

initCondsTypeTranslational = 'OrbitalParametersCircular'; % Circular orbit
initCondsTypeRotational = 'EulerAngles'; % Euler angles (3-2-1/yaw-pitch-roll convention)

% Translational state

initAlt = 500; % Initial orbital altitude [km]
initInc = 15; % Initial orbital inclination [º]
initRAAN = 0; % Initial orbital right ascension of the ascending node
initArgPer = 0; % Initial argument of the perigee [º]
initTrueAnomaly = 0; % Initial true anomaly [º]

% Rotational state

initRoll = 0; % Initial roll angle [º]
initPitch = 0; % Initial pitch angle [º]
initYaw = 0; % Initial yaw angle [º]

initOmgX = 0; % Initial angular velocity in X (body) axis [ºs-1]
initOmgY = 0; % Initial angular velocity in Y (body) axis [ºs-1]
initOmgZ = 0; % Initial angular velocity in Z (body) axis [ºs-1]

% Fuel mass

initFuelMass = 5; % Initial fuel mass [kg]

%% Mass properties

dryMass = 100; % Dry mass of the vehicle [kg]
dryInertia = 100 .* eye(3); % Inertia tensor of the vehicle without fuel [kgm2]
fullInertia = 110 .* eye(3); % Inertia tensor of the vehicle with fuel [kgm2]