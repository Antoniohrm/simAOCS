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
g0CelBod = 9.81; % Gravitational acceleration at Earth's surface [ms-2]

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

initCondsTypeTranslational = 'OrbitalParametersCircular'; % Circular orbit defined by the keplerian orbital elements
% initCondsTypeTranslational = 'LLAIncCirc'; % Inclined, circular orbit defined by latitude, longitude and altitude

initCondsTypeRotational = 'EulerAngles'; % Euler angles (3-2-1/yaw-pitch-roll convention)

% Translational state - Orbital parameters

initAlt = 500; % Initial orbital altitude [km]
initInc = 15; % Initial orbital inclination [º]
initRAAN = 0; % Initial orbital right ascension of the ascending node
initArgPer = 0; % Initial argument of the perigee [º]
initTrueAnomaly = 0; % Initial true anomaly [º]

% Translational state - LLA, inclination

% initAlt = 500; % Initial orbital altitude [km]
% initInc = 15; % Initial orbital inclination [º]
% initLat = 10; % Initial latitude [º]
% initLon = 75; % Initial longitude [º]

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

%% Aerodynamic properties

refSurf = 3; % Reference aerodynamic surface [m2]
dragCoeff = 2.5; % Drag coefficient (assumed constant) [-]

%% Actuators - Reaction wheels (RW)

rwAllocationMatrix = [ ... 
    1, 0, 0; ... 
    0, 1, 0; ... 
    0, 0, 1]; % RW allocation matrix (All three aligned with principal body axes)

rwInertia = 2; % Inertia moment of the RWs around their rotation axis [kgm2]
rwMaxOmg = 1e4; % Maximum angular velocity of the RW [rpm]

%% Actuators - Magnetorquers (MTQ)

mtqAllocationMatrix = [ ... 
    1, 0, 0; ... 
    0, 1, 0; ... 
    0, 0, 1]; % MTQ allocation matrix (All three aligned with principal body axes)

mtqResistance = 17.7; % Electrical resistance of the MTQs [Ohm]
mtqMagneticGain = 74.5; % Magnetic gain of the MTQs [Am2A-1]

mtqMaxVoltage = 5; % Maximum voltage to the MTQ [V]

%% Actuators - Reaction Control System (RCS)
% Cold gas thrusters (max thrust 1N)

rcsNumThrusters = 12; % Number of thrusters [#]

rcsPositionMatrix = [ ... 
    0, 1, 0; ... 
    0, 1, 0; ... 
    0, -1, 0; ... 
    0, -1, 0; ... 
    1, 0, 0; ... 
    1, 0, 0; ... 
    -1, 0, 0; ... 
    -1, 0, 0; ... 
    1, 0, 0; ... 
    1, 0, 0; ... 
    -1, 0, 0; ... 
    -1, 0, 0]; % RCS thrusters position matrix (Body frame, stacked by rows) [m]


rcsDirectionMatrix = [ ... 
    0, 0, 1; ... 
    0, 0, -1; ... 
    0, 0, -1; ... 
    0, 0, 1; ... 
    0, 0, -1; ... 
    0, 0, 1; ... 
    0, 0, 1; ... 
    0, 0, -1; ... 
    0, 1, 0; ... 
    0, -1, 0; ... 
    0, -1, 0; ... 
    0, 1, 0]; % RCS thrusters direction matrix (Body frame, stacked by rows) [-]

rcsIsp = 60; % RCS specific impulse [s]
rcsMaxMdot = 0.0017; % RCS maximum mass flow rate [kgs-1]

%% Actuators - Initial states
% MTQ and RCS assumed to be initialized at 0 output

rwInitOmg = ... 
    [0; 0; 0]; % Initial angular velocities of the RW [rpm]
