%% Import data from text file
% Script for importing data from the following text file:
%
%    filename: /Users/alikhajezade/Desktop/ODFCalcMethod-EDPlane/mscale.txt
%
% Auto-generated by MATLAB on 26-Dec-2020 21:51:48

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 4);

% Specify range and delimiter
opts.DataLines = [1, Inf];
opts.Delimiter = " ";

% Specify column names and types
opts.VariableNames = ["Var1", "VarName2", "VarName3", "Var4"];
opts.SelectedVariableNames = ["VarName2", "VarName3"];
opts.VariableTypes = ["string", "double", "double", "string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";

% Specify variable properties
opts = setvaropts(opts, ["Var1", "Var4"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var1", "Var4"], "EmptyFieldRule", "auto");

% Import the data
ms = readtable("mscale4.txt", opts);

%% Convert to output type
ms = table2array(ms);

%% Clear temporary variables
clear opts