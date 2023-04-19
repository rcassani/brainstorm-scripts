% Brainstorm script to generate a time series comprised of three coupling modes
% for the time-resolved phase-amplitude coupling tutorial
%
% https://neuroimage.usc.edu/brainstorm/Tutorials/TutPac
% https://neuroimage.usc.edu/brainstorm/Tutorials/TutPac#Time-resolved_PAC_estimation_with_tPAC
%
% Raymundo Cassani, 2023

% Subject name
SubjectName = 'Subject01';

% Process: Simulate PAC signals (version 1.2) 9:115 Hz
sFile1 = bst_process('CallProcess', 'process_pac_simulate', [], [], ...
    'subjectname', SubjectName, ...
    'condition',   'Simulation', ...
    'duration',    10, ...
    'srate',       1000, ...
    'nesting',     9, ...
    'nested',      115, ...
    'pacstr',      0.9, ...
    'coupling',    270, ...
    'cycle',       0.5, ...
    'snr',         6);

% Process: Simulate PAC signals (version 1.2) 13:145 Hz
sFile2a = bst_process('CallProcess', 'process_pac_simulate', [], [], ...
    'subjectname', SubjectName, ...
    'condition',   'Simulation', ...
    'duration',    10, ...
    'srate',       1000, ...
    'nesting',     13, ...
    'nested',      145, ...
    'pacstr',      0.9, ...
    'coupling',    0, ...
    'cycle',       0.5, ...
    'snr',         6);

% Process: Simulate PAC signals (version 1.2) 5:87 Hz
sFile2b = bst_process('CallProcess', 'process_pac_simulate', [], [], ...
    'subjectname', SubjectName, ...
    'condition',   'Simulation', ...
    'duration',    10, ...
    'srate',       1000, ...
    'nesting',     5, ...
    'nested',      87, ...
    'pacstr',      0.9, ...
    'coupling',    180, ...
    'cycle',       0.5, ...
    'snr',         6);

% Process: Average: Everything
sFile2 = bst_process('CallProcess', 'process_average', [sFile2a, sFile2b], [], ...
    'avgtype',       1, ...  % Everything
    'avg_func',      1, ...  % Arithmetic average:  mean(x)
    'weighted',      0, ...
    'keepevents',    0, ...
    'matchrows',     0, ...
    'iszerobad',     1);

% Process: Concatenate time
sFile3 = bst_process('CallProcess', 'process_concat', [sFile1, sFile2], []);

% Process: Set name: Simulated PAC - three modes
bst_process('CallProcess', 'process_set_comment', sFile3, [], ...
    'tag',           'Simulated PAC - three modes', ...
    'isindex',       1);

% Process: Delete selected files
sFiles = bst_process('CallProcess', 'process_delete', [sFile1, sFile2a, sFile2b, sFile2], [], ...
    'target', 1);  % Delete selected files



