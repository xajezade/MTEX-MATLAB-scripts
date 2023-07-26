%% Import Script for EBSD Data
%
% This script loads and smooth the EBSD data: removing small grains, 1
% iteration of smoothing with half-quadratic filter, filling up the missing
% pixels

%% Specify Crystal and Specimen Symmetries

% crystal symmetry
CS = {... 
  'notIndexed',...
  crystalSymmetry('432', [4 4 4], 'mineral', 'Aluminum', 'color', [0.53 0.81 0.98])};

% plotting convention
setMTEXpref('xAxisDirection','north');
setMTEXpref('zAxisDirection','outOfPlane');

%% Specify File Names

% path to files
pname = '';

% which files to be imported
fname = [pname '375C24H_300C32mms70-1_FromEdge_11.osc'];

%% Import the Data

% create an EBSD variable containing the data
ebsd = EBSD.load(fname,CS,'interface','osc',...
  'convertEuler2SpatialReferenceFrame');
ebsd=ebsd('indexed');
disp('Raw EBSD data was loaded!')
%removing pixels with low confidence index (CI>85%)
ebsd=ebsd(ebsd.prop.confidenceindex>0.15);
[grains,ebsd.grainId,ebsd.mis2mean] = calcGrains(ebsd,'threshold',15*degree);
% removing small grains
ebsd_noSmallGrain=ebsd(grains(grains.grainSize>20));
disp('Small grains and low confidence indices were removed!')
disp('Denoising is started!')
[grains,ebsd_noSmallGrain.grainId,ebsd_noSmallGrain.mis2mean] = calcGrains(ebsd_noSmallGrain,'threshold',2*degree);
f = halfQuadraticFilter;
f.alpha=0.1;
ebsd_smooth=smooth(ebsd_noSmallGrain,f,'fill');
disp('Denoising Completed!')
ebsd=ebsd_smooth;
ebsd=ebsd('indexed');