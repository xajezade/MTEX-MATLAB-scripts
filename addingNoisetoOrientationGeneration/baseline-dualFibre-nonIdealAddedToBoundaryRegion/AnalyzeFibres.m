%% Import Script for EBSD Data
%
% This script was automatically created by the import wizard. You should
% run the whoole script or parts of it in order to import your data. There
% is no problem in making any changes to this script.

%% Specify Crystal and Specimen Symmetries

% crystal symmetry
CS = {... 
  'notIndexed',...
  crystalSymmetry('m-3m', [4 4 4], 'mineral', 'Aluminum')};

% plotting convention
setMTEXpref('xAxisDirection','east');
setMTEXpref('zAxisDirection','outOfPlane');
fvol=zeros(51,3);
counter=1;
for i=0:1000:0
%% Specify File Names

% path to files
pname = '';

% which files to be imported
fname = [pname strcat('ebsd',num2str(i),'.txt')];

%% Import the Data

% create an EBSD variable containing the data
ebsd = EBSD.load(fname,CS,'interface','generic',...
  'ColumnNames', { 'phi1' 'Phi' 'phi2' 'x' 'y' 'SemSignal'}, 'Bunge');
f001 = fibre(Miller(0,0,1,ebsd.CS),zvector);
f111 = fibre(Miller(1,1,1,ebsd.CS),zvector);
eb=ebsd.gridify;
eb=eb(1:2048,1:2048);
ori=eb.orientations;
v001=100 * volume(ori,f001,15*degree);
v111=100 * volume(ori,f111,15*degree);
others=100-(v001+v111);
fvol(counter,1)=v001;
fvol(counter,2)=v111;
fvol(counter,3)=others;
counter=counter+1;
clear ebsd eb ori v001 v111 others f001 f111 
end
writematrix(fvol,'fibres-vol.txt','Delimiter',',')