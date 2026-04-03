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

% initOmgX = 0; % Initial angular velocity in X (body) axis [ºs-1]
% initOmgY = 0; % Initial angular velocity in Y (body) axis [ºs-1]
% initOmgZ = 0; % Initial angular velocity in Z (body) axis [ºs-1]

initOmgX = 2; % Initial angular velocity in X (body) axis [ºs-1]
initOmgY = 2; % Initial angular velocity in Y (body) axis [ºs-1]
initOmgZ = 2; % Initial angular velocity in Z (body) axis [ºs-1]

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

%% Sensors - Gyroscope (GYR)

gyrUpdateFreq = 20; % Reading frequency of the gyroscope [Hz]

gyrMeasLim = 400; % Maximum measurable angular velocity magnitude [ºs-1]

gyrARWperChannel = 0.15; % Angular Random Walk (Allan variance) [ºh^-0.5]

%% Sensors - Star tracker (STR)

strUpdateFreq = 5; % Reading frequency of the star tracker [Hz]

strNoisePerChannel = 20; % Noise per Euler angle (3 sigma) [arcSec]

strBiasPerChannel = 10; % Noise bias per Euler angle (3 sigma) [arcSec]

%% Sensors - Magnetometer (MAG)

magUpdateFreq = 5; % Reading frequency of the magnetometer [Hz]

magMeasLim = ... 
    8; % Maximum measurable magnetic field magnitude per channel [Gauss]

magNoisePerChannel = ... 
    50; % Noise per channel (3 sigma) [nT]

%% Sensors - Global Navigation Satellite System (GNSS)

gnssUpdateFreq = 2; % Reading frequency of the GNSS receiver [Hz]

gnssHorzAcc = 1.6; % Horizontal accuracy of the GNSS receiver [m]
gnssVertAcc = 3; % Vertical accuracy of the GNSS receiver [m]
gnssVelAcc = 0.1; % Velocity accuracy of the GNSS receiver [ms-1]

%% Sensors - RW encoders (RWE)

rweUpdateFreq = 20; % Reading frequency of the RWE [Hz]

%% Random error seeds
% Initialize seeds of random sources for results repeatability

% Main seed generation

mainSeed = 23340; % Main seed for the simulation
seedsMax = 50000; % Max values for random seeds

%% GNC

% Modes

modeIds = { ... 
    "Safe", 1; ... 
    "Desaturation", 2; ... 
    "Science", 3}; % Mode ids, first column are names (postpro), second column are IDs

% Note: The mode IDs names shall be defined as strings (delimited by "),
% not as character arrays (delimited by ') for postprocessing purposes

initMode = 1; % Initial mode

omgBodSafeTH = 15; % Body angular velocity threshold to trigger safe mode [ºs-1]
omgRwDesaturationTH = 0.5; % RW angular velocity threshold to trigger desaturation [frac of max RW omg]

% Navigation

% Fine navigation algorithm
% Currently supports only STR and STR + GYR propagation between STR updates

% fineNavMode = 1; % Only update Eci2Body attitude from the STR measurements
fineNavMode = 2; % Propagate attitude with the gyro measurements between STR updates