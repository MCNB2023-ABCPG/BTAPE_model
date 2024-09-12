function glm_spec(folder_path_root, folder_path_derivatives, folder_path_glm, file_path_info)

% variables
sub_all = {'001', '002'};
run_all = {'001', '002', '003', '004', '005', '006', '007'};

sub_run_comb = ...
{
    {'001', '001'}, {'001', '002'}, {'001', '003'}, {'001', '004'}, {'001', '005'}, {'001', '006'}, {'001', '007'},...
    {'002', '001'}, {'002', '002'}, {'002', '003'}, {'002', '004'}, {'002', '005'}, {'002', '006'}, {'002', '007'},...
    {'004', '001'}, {'004', '002'}, {'004', '003'}, {'004', '004'}, {'004', '005'}, {'004', '006'}, {'004', '007'}
};


bistable_struct{1}.name = 'ALT';
bistable_struct{1}.id = 1;
bistable_struct{1}.duration = 24;
bistable_struct{2}.name = 'SIM';
bistable_struct{2}.id = 2;
bistable_struct{2}.duration = 24;

localizer_struct{1}.name = 'LEFT';
localizer_struct{1}.duration = 8;
localizer_struct{1}.id = 1;
localizer_struct{2}.name = 'RIGHT';
localizer_struct{2}.duration = 8;
localizer_struct{2}.id = 2;


% speccify model
job = [];
job{1}.spm.stats.fmri_spec.dir = {folder_path_glm};
job{1}.spm.stats.fmri_spec.timing.units = 'secs';
job{1}.spm.stats.fmri_spec.timing.RT = 1;
job{1}.spm.stats.fmri_spec.timing.fmri_t = 16;
job{1}.spm.stats.fmri_spec.timing.fmri_t0 = 8;

job{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
job{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
job{1}.spm.stats.fmri_spec.volt = 1;
job{1}.spm.stats.fmri_spec.global = 'None';
job{1}.spm.stats.fmri_spec.mthresh = 0.95;
job{1}.spm.stats.fmri_spec.mask = {''};
job{1}.spm.stats.fmri_spec.cvi = 'AR(1)';


for i=1:numel(sub_run_comb)

if i < 8
    sub_int = 1;
elseif i < 16 || i >= 8
    sub_int = 2;
else
    sub_int = 4;
end

sub_cur = sub_run_comb{i}{1};
run_cur = sub_run_comb{i}{2};


if ~strcmp(run_cur, '007')

folder_path_func = fullfile(folder_path_derivatives, 'A_bistable_perception', ['sub-',sub_cur], 'func');
pattern = strcat('^sw.*','run-', run_cur, '.*\.nii$');
file_path_run = cellstr(spm_select('ExtFPListRec', folder_path_func, pattern));

folder_path_log = fullfile(folder_path_root, '', ['sub-',sub_cur], 'func');
pattern = strcat('^.*','run-', run_cur, '.*\.mat$');
file_path_log = spm_select('FPList', folder_path_log, pattern);

pattern = strcat('^rp.*','run-', run_cur, '.*\.txt$');
file_path_motion = spm_select('FPList', folder_path_func, pattern);


job{1}.spm.stats.fmri_spec.sess(i).scans = file_path_run;

for j=[1,2]

    [onset, offset] = get_onset_ext(file_path_log, file_path_info, j, sub_int, 0);

    job{1}.spm.stats.fmri_spec.sess(i).cond(j).name = bistable_struct{j}.name;
    job{1}.spm.stats.fmri_spec.sess(i).cond(j).onset = onset;
    job{1}.spm.stats.fmri_spec.sess(i).cond(j).duration = bistable_struct{j}.duration; %- offset;
    job{1}.spm.stats.fmri_spec.sess(i).cond(j).tmod = 1;
    job{1}.spm.stats.fmri_spec.sess(i).cond(j).pmod = struct('name', {}, 'param', {}, 'poly', {});
    job{1}.spm.stats.fmri_spec.sess(i).cond(j).orth = 1;
    
    job{1}.spm.stats.fmri_spec.sess(i).multi = {''};
    job{1}.spm.stats.fmri_spec.sess(i).regress = struct('name', {}, 'val', {});
    job{1}.spm.stats.fmri_spec.sess(i).multi_reg = {file_path_motion};
    job{1}.spm.stats.fmri_spec.sess(i).hpf = 128;
end


else

folder_path_func = fullfile(folder_path_derivatives, 'B_localizer', ['sub-',sub_cur], 'func');
pattern = strcat('^sw.*','run-', run_cur, '.*\.nii$');
file_path_run = cellstr(spm_select('ExtFPListRec', folder_path_func, pattern));

folder_path_log = fullfile(folder_path_root, '', ['sub-',sub_cur], 'func');
pattern = strcat('^.*','run-', run_cur, '.*\.mat$');
file_path_log = spm_select('FPList', folder_path_log, pattern);

pattern = strcat('^rp.*','run-', run_cur, '.*\.txt$');
file_path_motion = spm_select('FPList', folder_path_func, pattern);


job{1}.spm.stats.fmri_spec.sess(i).scans = file_path_run;

for j=[1,2]

    [onset, offset] = get_onset_ext(file_path_log, file_path_info, j, sub_int, 0);

    job{1}.spm.stats.fmri_spec.sess(i).cond(j).name = localizer_struct{j}.name;
    job{1}.spm.stats.fmri_spec.sess(i).cond(j).onset = onset;
    job{1}.spm.stats.fmri_spec.sess(i).cond(j).duration = localizer_struct{j}.duration;
    job{1}.spm.stats.fmri_spec.sess(i).cond(j).tmod = 0;
    job{1}.spm.stats.fmri_spec.sess(i).cond(j).pmod = struct('name', {}, 'param', {}, 'poly', {});
    job{1}.spm.stats.fmri_spec.sess(i).cond(j).orth = 1;
    
    job{1}.spm.stats.fmri_spec.sess(i).multi = {''};
    job{1}.spm.stats.fmri_spec.sess(i).regress = struct('name', {}, 'val', {});
    job{1}.spm.stats.fmri_spec.sess(i).multi_reg = {file_path_motion};
    job{1}.spm.stats.fmri_spec.sess(i).hpf = 128;
end

end

end

spm_jobman('run', job);

end