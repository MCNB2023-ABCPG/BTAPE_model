%% path specification
folder_path_root = '/Users/pschm/BTAPE_local';
spm_path = '/Users/pschm/spm12_dev_main';
folder_path_code = '/Users/pschm/icloud_link/University/mcnb/2_semester/NMP/BTAPE_model';


%% initialization
addpath(spm_path)
addpath(genpath(folder_path_code))
spm('defaults', 'fmri') 
spm_jobman('initcfg')


%% set additional paths
folder_path_derivatives = fullfile(folder_path_root, 'derivatives');
folder_path_glm = fullfile(folder_path_derivatives, 'model_main');
file_path_info = fullfile(folder_path_derivatives, 'BTAPE_Info', 'BTAPE-sub-Data_clean.xlsx');

if ~exist(folder_path_glm, 'dir')
       mkdir(folder_path_glm)
end

%% Switch
switch_prep = [3];


%% GLM specification
if any(switch_prep == 1)
    glm_spec(folder_path_root, folder_path_derivatives, folder_path_glm, file_path_info);
end


%% estimate
if any(switch_prep == 2)
    glm_est(folder_path_glm);
end


%% contrasts
if any(switch_prep == 3)
    contrasts(folder_path_glm);
end


%% clean up
rmpath(spm_path)
rmpath(genpath(folder_path_code))
