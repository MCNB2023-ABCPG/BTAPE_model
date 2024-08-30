function glm_est(folder_path_glm)

job = [];
file_path_design = spm_select('FPList', folder_path_glm, '^SPM.mat$');
job{1}.spm.stats.fmri_est.spmmat = {file_path_design};
job{1}.spm.stats.fmri_est.write_residuals = 0;
job{1}.spm.stats.fmri_est.method.Classical = 1;

spm_jobman('run', job);


end 