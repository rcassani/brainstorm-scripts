% Script to generate and add a Brainstorm matrix file, 
%  and review it as raw recordings
%
% Raymundo Cassani, 2023

%% Parameters 
% Simulated signals
channelNames = {'s1', 's2', 's3', 's4', 's5'};  % Channel names
timeVector   = (0 : 10000-1)' / 1000;           % [1, nTimePoints]
dataMatrix   = randn(length(channelNames), length(timeVector));    % [nChannels, nTimePoints]
% Database explorer (tree) parameters
SubjectName   = 'NewSubject';
ConditionName = 'NewCondition';

%% Create matrix file and add it to Protocol
% Get subject
[sSubject, iSubject] = db_add_subject(SubjectName);
%Create empty matrix file structure
FileMat             = db_template('matrixmat');
FileMat.Value       = dataMatrix;
FileMat.Time        = timeVector;
FileMat.Comment     = 'Simulated signals';
FileMat.Description = channelNames;
% Create a new condition for matrix file
iStudy = db_add_condition(sSubject.Name, ConditionName);
% Add matrix file to the database
FileName = db_add(iStudy, FileMat);
% Review as raw
import_raw(file_fullpath(FileName), 'BST-MATRIX', iSubject);
