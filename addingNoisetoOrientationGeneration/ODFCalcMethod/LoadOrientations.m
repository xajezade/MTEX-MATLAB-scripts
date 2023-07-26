%% Import data from text file
% Script for importing data from the following text file:
%
%    filename: C:\Users\alixa\Documents\myPROJECTS\Aluminium\addingNoisetoOrientationGeneration\ODFCalcMethod\LargerDomain\ODF.txt
%
% Auto-generated by MATLAB on 21-Jul-2023 16:13:37

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 3);

% Specify range and delimiter
opts.DataLines = [1, Inf];
opts.Delimiter = "\t";

% Specify column names and types
opts.VariableNames = ["VarName1", "VarName2", "VarName3"];
opts.VariableTypes = ["double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
ODF = readtable("ODF.txt", opts);

%% Convert to output type
ODF = table2array(ODF);

%% Clear temporary variables
clear opts