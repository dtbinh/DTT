%
% ginit.m
% file for defining global variable values

% general size information
WORLD_SIZE=100000; 		% size of the world in meters
MAX_TIME=100;				% simulation time (seconds)
DT=1;							% default simulation time increment
APPLY_BOUNDS = 0;			% do modulo arthimetic

% Definitions for targets
TARGET_TYPE=1;			% 1=xy target, 2=V phi target
NUM_TARGETS = 1;			% number of targets to be tracked
TARGET_B=20;				% turning base-line
TARGET_VEL_SD=2;		% velocity Standard deviation
TARGET_GAMMA_SD=0.00025; % turn rate Standard deviation
MAX_TARGET_VEL=300;	% maximum target velocity
MIN_TARGET_VEL=150;	% minimum target velocity
MAX_TARGET_GAMMA=0.0025; % maximum turn rate


% number of sensor nodes
NUM_NODES = 6; % modified by landcolin
NUM_CHANS=1;

% sensor definitions
SIGMA_RANGE=50;
SIGMAR2=2500;
SIGMA_BEARING=0.0087;
SIGMAB2=7.5690e-005;

% state and observation dimensions
XSIZE=4;
ZSIZE=2;

SIGMA_XY=20;
