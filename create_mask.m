function create_mask(folder_path_derivatives)

folder_path_anat = fullfile(folder_path_derivatives, 'A_bistable_perception', 'sub-001', 'anat');

file_path_segm = cellstr(spm_select('FPList', folder_path_anat, '^c[1 2 3].*$'));

job{1}.spm.util.imcalc.input = file_path_segm;
job{1}.spm.util.imcalc.output = 'explicit_mask';
job{1}.spm.util.imcalc.outdir = {folder_path_anat};
%job{1}.spm.util.imcalc.expression = 'i1 > 0.8 & i2 > 0.8 & i3 < 0.05 & i4 < 0.05 & i5 < 0.05';
job{1}.spm.util.imcalc.expression = 'i1 > 0.5 | i2 > 0.5 | i3 > 0.5';
job{1}.spm.util.imcalc.var = struct('name', {}, 'value', {});
job{1}.spm.util.imcalc.options.dmtx = 0;
job{1}.spm.util.imcalc.options.mask = 0;
job{1}.spm.util.imcalc.options.interp = 1;
job{1}.spm.util.imcalc.options.dtype = 4;

spm_jobman('run', job);

end