% globals.m 
% global definitions for multi-target tracker

% general size information
global WORLD_SIZE; 		% size of the world in meters
global DT; % simulation time-step
global MAX_TIME; % Max simulation time
global APPLY_BOUNDS; % decide to do a mod world

% stuff for targets
global TARGET_TYPE		% defines type of target (xy or V phi)
global NUM_TARGETS;		% number of targets to be simulated
global TARGET_B;
global TARGET_VEL_SD;
global TARGET_GAMMA_SD;
global MAX_TARGET_VEL;
global MAX_TARGET_GAMMA;
global MIN_TARGET_VEL;

% Platform definitions
global PLATFORM;	 % Platform data [x0, y0, phi0, vel]
global NUM_PLATFORMS; % number of platforms
global MAX_RANGE;  % maximum observable range
global BEAM_SIZE;  % maximum half beam size
global SIGMA_XY;   % observation noise standard deviation for model
global SIGMA_Q;	 % process noise standard deviation for feature model
global SIGMA_R;	 % Range observation noise
global SIGMA_THETA;% Bearing observation noise
global SIGMAR2;	 % Range error variance
global SIGMAB2;    % bearing error variance

global NUM_NODES;	 % number of sensor nodes
% global NUM_CHANS;  % number of channels per node
% global FULL_CON;   % connectivity

% stuff used in simulations
global R;  % observation noise covariance
global Rinv; % inverse of R
global H;  % observation model
global F;  % state transition equation

global OBS_GATE; % The gate for data association
global SIGMA_RANGE;
global SIGMA_BEARING;
