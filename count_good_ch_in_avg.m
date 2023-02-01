% Count how many good channels were used to compute the across-files average
%
% Raymundo Cassani, 2023

% Input files
sFiles = {...
    'NewSubject/example_w_bad/data_block001.mat', ...
    'NewSubject/example_w_bad/data_block002.mat', ...
    'NewSubject/example_w_bad/data_block003.mat'};

% Process: Average: Everything
sFiles = bst_process('CallProcess', 'process_average', sFiles, [], ...
    'avgtype',       1, ...  % Everything
    'avg_func',      1, ...  % Arithmetic average:  mean(x)
    'weighted',      0, ...
    'keepevents',    1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Count the number of epochs used for the average in each channel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Get channel flag for each one
sFile = in_bst_data(sFiles{1});
% Total channel flag
totalChannelFlag = 0 * sFile.ChannelFlag;
for iFile = 1 : numel(sFiles)
    sFile = in_bst_data(sFiles{iFile}, 'ChannelFlag');
    totalChannelFlag = totalChannelFlag + (sFile.ChannelFlag > 0);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



