% path specification
folder_path_root = '/Users/pschm/BTAPE_local';
spm_path = '/Users/pschm/spm12_dev_main';
folder_path_code = '/Users/pschm/icloud_link/University/mcnb/2_semester/NMP/BTAPE_model';


% initialization
addpath(spm_path)
addpath(fullfile(folder_path_code,'helper_functions'))
spm('defaults', 'fmri') 
spm_jobman('initcfg')


% set additional paths
folder_path_derivatives = fullfile(folder_path_root, 'derivatives');
folder_path_glm = fullfile(folder_path_derivatives, 'model_main');
file_path_info = fullfile(folder_path_derivatives, 'BTAPE_Info', 'BTAPE-sub-Data_clean.xlsx');

if ~exist(folder_path_glm, 'dir')
       mkdir(folder_path_glm)
end


% variables
sub_all = {'001', '002'};
run_all = {'001', '002', '003', '004', '005', '006', '007'};

sub_run_comb = ...
{
    {'001', '001'}, {'001', '002'}, {'001', '003'}, {'001', '004'}, {'001', '005'}, {'001', '006'}, {'001', '007'},...
    {'002', '001'}, {'002', '002'}, {'002', '003'}, {'002', '004'}, {'002', '005'}, {'002', '006'}, {'002', '007'}
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
job{1}.spm.stats.fmri_spec.mthresh = 0.8;
job{1}.spm.stats.fmri_spec.mask = {''};
job{1}.spm.stats.fmri_spec.cvi = 'AR(1)';


for i=1:numel(sub_run_comb)

if i < 8
    sub_int = 1;
else 
    sub_int = 2;
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

    [onset, offset] = get_onset_ext(file_path_log, file_path_info, j, sub_int, 1);

    job{1}.spm.stats.fmri_spec.sess(i).cond(j).name = bistable_struct{j}.name;
    job{1}.spm.stats.fmri_spec.sess(i).cond(j).onset = onset;
    job{1}.spm.stats.fmri_spec.sess(i).cond(j).duration = bistable_struct{j}.duration - offset;
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


% estimate
job = [];
file_path_design = spm_select('FPList', folder_path_glm, '^SPM.mat$');
job{1}.spm.stats.fmri_est.spmmat = {file_path_design};
job{1}.spm.stats.fmri_est.write_residuals = 0;
job{1}.spm.stats.fmri_est.method.Classical = 1;

spm_jobman('run', job);


% contrasts
job = [];
file_path_design = spm_select('FPList', folder_path_glm, '^SPM.mat$');
job{1}.spm.stats.con.spmmat = {file_path_design};

job{1}.spm.stats.con.consess{1}.tcon.name = 'sub001 ALT';
job{1}.spm.stats.con.consess{1}.tcon.weights = repmat([1 0 0 0 0 0 0 0 0 0],1, 6);
job{1}.spm.stats.con.consess{1}.tcon.sessrep = 'none';

job{1}.spm.stats.con.consess{2}.tcon.name = 'sub001 SIM';
job{1}.spm.stats.con.consess{2}.tcon.weights = repmat([0 1 0 0 0 0 0 0 0 0],1, 6);
job{1}.spm.stats.con.consess{2}.tcon.sessrep = 'none';

job{1}.spm.stats.con.consess{3}.tcon.name = 'sub002 ALT';
job{1}.spm.stats.con.consess{3}.tcon.weights = [repmat(repelem(0,10),1,6) repelem(0,8) repmat([1 0 0 0 0 0 0 0 0 0],1, 6)];
job{1}.spm.stats.con.consess{3}.tcon.sessrep = 'none';

job{1}.spm.stats.con.consess{4}.tcon.name = 'sub002 SIM';
job{1}.spm.stats.con.consess{4}.tcon.weights = [repmat(repelem(0,10),1,6) repelem(0,8) repmat([0 1 0 0 0 0 0 0 0 0],1, 6)];
job{1}.spm.stats.con.consess{4}.tcon.sessrep = 'none';

job{1}.spm.stats.con.consess{5}.tcon.name = 'sub001 Localizer LEFT AND RIGHT';
job{1}.spm.stats.con.consess{5}.tcon.weights = [repmat(repelem(0,10),1,6) [1 1 0 0 0 0 0 0]];
job{1}.spm.stats.con.consess{5}.tcon.sessrep = 'none';

job{1}.spm.stats.con.consess{6}.tcon.name = 'sub002 Localizer LEFT AND RIGHT';
job{1}.spm.stats.con.consess{6}.tcon.weights = [repmat(repelem(0,10),1,6) repelem(0,8) repmat(repelem(0,10),1,6) [1 1 0 0 0 0 0 0]];
job{1}.spm.stats.con.consess{6}.tcon.sessrep = 'none';

job{1}.spm.stats.con.consess{7}.tcon.name = 'sub001 & sub002 ALT';
job{1}.spm.stats.con.consess{7}.tcon.weights = [repmat([1 0 0 0 0 0 0 0 0 0],1, 6) repelem(0,8) repmat([1 0 0 0 0 0 0 0 0 0],1, 6)];
job{1}.spm.stats.con.consess{7}.tcon.sessrep = 'none';

job{1}.spm.stats.con.consess{8}.tcon.name = 'sub001 & sub002 SIM';
job{1}.spm.stats.con.consess{8}.tcon.weights = [repmat([0 0 1 0 0 0 0 0 0 0],1, 6) repelem(0,8) repmat([0 0 1 0 0 0 0 0 0 0],1, 6)];
job{1}.spm.stats.con.consess{8}.tcon.sessrep = 'none';

job{1}.spm.stats.con.consess{9}.tcon.name = 'sub001 & sub002 Localizer LEFT AND RIGHT';
job{1}.spm.stats.con.consess{9}.tcon.weights = [repmat(repelem(0,10),1,6) [1 1 0 0 0 0 0 0] repmat(repelem(0,10),1,6) [1 1 0 0 0 0 0 0]];
job{1}.spm.stats.con.consess{9}.tcon.sessrep = 'none';


sub_all_runs_eye = eye(68);
for i=1:6
    sub_all_runs_eye(:,(i*10-8):(i*10)) = 0;
end
sub_all_runs_eye(:,end-8:end)=0;

job{1}.spm.stats.con.consess{10}.fcon.name = 'sub001 & sub002 ALT F over run';
job{1}.spm.stats.con.consess{10}.fcon.weights = [sub_all_runs_eye sub_all_runs_eye];
job{1}.spm.stats.con.consess{10}.fcon.sessrep = 'none';


sub_all_runs_eye = eye(68);
sub_all_runs_eye(:,1:2)=0;
for i=1:6
    sub_all_runs_eye(:,(i*10-6):(i*10+2)) = 0;
end
sub_all_runs_eye(:,end-8:end)=0;

job{1}.spm.stats.con.consess{11}.fcon.name = 'sub001 & sub002 SIM F over run';
job{1}.spm.stats.con.consess{11}.fcon.weights = [sub_all_runs_eye sub_all_runs_eye];
job{1}.spm.stats.con.consess{11}.fcon.sessrep = 'none';


%sub_all_runs_eye = [repelem(0,60) 1 0 repelem(0,6); repelem(0,60) 0 1 repelem(0,6)];

sub_all_runs_eye = eye(68);
sub_all_runs_eye(:,1:60)=0;
sub_all_runs_eye(:,63:end)=0;

job{1}.spm.stats.con.consess{12}.fcon.name = 'sub001 & sub002 LOCALIZER F';
job{1}.spm.stats.con.consess{12}.fcon.weights = [sub_all_runs_eye sub_all_runs_eye];
job{1}.spm.stats.con.consess{12}.fcon.sessrep = 'none';


sub_all_runs_eye = eye(68);
for i=1:6
    sub_all_runs_eye(:,(i*10-8):(i*10)) = 0;
end
sub_all_runs_eye(:,end-8:end)=0;
job{1}.spm.stats.con.consess{13}.fcon.name = 'sub001 ALT F';
job{1}.spm.stats.con.consess{13}.fcon.weights = sub_all_runs_eye;
job{1}.spm.stats.con.consess{13}.fcon.sessrep = 'none';


job{1}.spm.stats.con.consess{14}.fcon.name = 'sub002 ALT F';
job{1}.spm.stats.con.consess{14}.fcon.weights = [zeros(68) sub_all_runs_eye];
job{1}.spm.stats.con.consess{14}.fcon.sessrep = 'none';


sub_all_runs_eye = eye(68);
sub_all_runs_eye(:,1:2)=0;
for i=1:6
    sub_all_runs_eye(:,(i*10-6):(i*10+2)) = 0;
end
sub_all_runs_eye(:,end-8:end)=0;

job{1}.spm.stats.con.consess{15}.fcon.name = 'sub001 SIM F';
job{1}.spm.stats.con.consess{15}.fcon.weights = sub_all_runs_eye;
job{1}.spm.stats.con.consess{15}.fcon.sessrep = 'none';


job{1}.spm.stats.con.consess{16}.fcon.name = 'sub002 SIM F';
job{1}.spm.stats.con.consess{16}.fcon.weights = [zeros(68) sub_all_runs_eye];
job{1}.spm.stats.con.consess{16}.fcon.sessrep = 'none';


job{1}.spm.stats.con.delete = 1;

spm_jobman('run', job);



rmpath(spm_path)
rmpath(fullfile(folder_path_code,'helper_functions'))

