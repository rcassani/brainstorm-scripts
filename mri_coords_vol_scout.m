% Parameters
VolSourceFileName = 'Subject01/SubjectCMC_notch_high_abs/results_MN_MEG_KERNEL_230417_1513.mat';
VolAtlasName = 'Volume 10094: testForum';
VolScoutName = 'TestScout2';

% Find VolScout in VolAtlas, this can be done in the GUI by exporting the Scout to Matlab
sResults = in_bst_results(VolSourceFileName, [], 'HeadModelFile');
sVolHeadModelFileName = in_bst_headmodel(sResults.HeadModelFile, [], 'SurfaceFile', 'GridLoc');
sSurf = in_tess_bst(sVolHeadModelFileName.SurfaceFile);
sSubject = bst_get('SurfaceFile', sVolHeadModelFileName.SurfaceFile);
sMri = in_mri_bst(sSubject.Anatomy(sSubject.iAnatomy).FileName);
iAtlas = find(strcmp(VolAtlasName, {sSurf.Atlas.Name}));
iScout = find(strcmp(VolScoutName, {sSurf.Atlas(iAtlas).Scouts.Label}));
sScout = sSurf.Atlas(iAtlas).Scouts(iScout); 

% Get SCS locations for VolScout vertices
verticesScsLoc = sVolHeadModelFileName.GridLoc(sScout.Vertices, :);

% Interpolate SCS locations to MRI voxels
verticesVoxelLoc = cs_convert(sMri, 'scs', 'voxel', verticesScsLoc);
