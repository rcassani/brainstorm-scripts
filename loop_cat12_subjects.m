% Segment MRI with CAT12 for multiple subjects
%
% Raymundo Cassani, 2023

% Input files
sFiles = [];
SubjectNames = {'Subject01', 'Subject02'};

% Start a new report
bst_report('Start', sFiles);

for iSubject = 1 : length(SubjectNames)
    % Process: Segment MRI with CAT12
    sFiles = bst_process('CallProcess', 'process_segment_cat12', sFiles, [], ...
        'subjectname', SubjectNames{iSubject}, ...
        'nvertices',   15000, ...
        'tpmnii',      {'', 'Nifti1'}, ...
        'sphreg',      1, ...
        'vol',         1, ...
        'extramaps',   0, ...
        'cerebellum',  0);
end

% Save and display report
ReportFile = bst_report('Save', sFiles);
bst_report('Open', ReportFile);
% bst_report('Export', ReportFile, ExportDir);
% bst_report('Email', ReportFile, username, to, subject, isFullReport);

