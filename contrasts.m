function contrasts(folder_path_glm)


nsub = 1;
sub_all = {'sub-001'}

job = [];
file_path_design = spm_select('FPList', folder_path_glm, '^SPM.mat$');
job{1}.spm.stats.con.spmmat = {file_path_design};



%% F Omnibus Contrasts
f_contrast = [repmat([1 0 1 0 repelem(0,1,6)],1,6) repelem(0,1,10)];
f_matrix = diag(repmat(f_contrast,1,nsub));

job{1}.spm.stats.con.consess{1}.fcon.name = 'F bistable omnibus';
job{1}.spm.stats.con.consess{1}.fcon.weights = f_matrix;
job{1}.spm.stats.con.consess{1}.fcon.sessrep = 'none';

job{1}.spm.stats.con.consess{2}.fcon.name = 'F bistable TM omnibus';
job{1}.spm.stats.con.consess{2}.fcon.weights = [repelem(0,nsub*70,1) f_matrix];
job{1}.spm.stats.con.consess{2}.fcon.sessrep = 'none';

f_contrast = [repmat(repelem(0,1,10),1,6) [1 0 1 0 0 0 0 0 0 0]];
f_matrix = diag(repmat(f_contrast,1,nsub));

job{1}.spm.stats.con.consess{3}.fcon.name = 'F localizer omnibus';
job{1}.spm.stats.con.consess{3}.fcon.weights = f_matrix;
job{1}.spm.stats.con.consess{3}.fcon.sessrep = 'none';

f_contrast = [repmat([1 0 0 0 repelem(0,1,6)],1,6) repelem(0,1,10)];
f_matrix = diag(repmat(f_contrast,1,nsub));

f_matrix = f_matrix + [repelem(0,nsub*70,2) f_matrix(:,1:end-2)];
job{1}.spm.stats.con.consess{4}.fcon.name = 'F bistable averaged omnibus';
job{1}.spm.stats.con.consess{4}.fcon.weights = f_matrix;
job{1}.spm.stats.con.consess{4}.fcon.sessrep = 'none';


%% T contrast simple
t_contrast_sub = [repmat([1 0 -1 0 repelem(0,1,6)],1,6) repelem(0,1,10)];
%t_contrast = [t_contrast_sub repelem(0,1,70) t_contrast_sub];
%t_contrast = [t_contrast_sub t_contrast_sub t_contrast_sub];
job{1}.spm.stats.con.consess{5}.tcon.name = 't contrast ALT>SIM';
job{1}.spm.stats.con.consess{5}.tcon.weights = t_contrast_sub;
job{1}.spm.stats.con.consess{5}.tcon.sessrep = 'none';


t_contrast_sub = [repmat([-1 0 1 0 repelem(0,1,6)],1,6) repelem(0,1,10)];
%t_contrast = [t_contrast_sub repelem(0,1,70) t_contrast_sub];
%t_contrast = [t_contrast_sub t_contrast_sub t_contrast_sub];
job{1}.spm.stats.con.consess{6}.tcon.name = 't contrast SIM>ALT';
job{1}.spm.stats.con.consess{6}.tcon.weights = t_contrast_sub;
job{1}.spm.stats.con.consess{6}.tcon.sessrep = 'none';

%% T contrast average sub localizer
t_contrast_sub = [repmat((1/3)*[1 0 0 0 repelem(0,1,6)],1,6) [-1 0 -1 0 repelem(0,1,6)]];
%t_contrast_sub = [repmat([1 0 0 0 repelem(0,1,6)],1,6) [-1 0 -1 0 repelem(0,1,6)]];
%t_contrast = [t_contrast_sub repelem(0,1,70) t_contrast_sub];
job{1}.spm.stats.con.consess{7}.tcon.name = 't contrast ALT>localizer';
job{1}.spm.stats.con.consess{7}.tcon.weights = t_contrast_sub;
job{1}.spm.stats.con.consess{7}.tcon.sessrep = 'none';


t_contrast_sub = [repmat((1/3)*[0 0 1 0 repelem(0,1,6)],1,6) [-1 0 -1 0 repelem(0,1,6)]];
%t_contrast_sub = [repmat([0 0 1 0 repelem(0,1,6)],1,6) [-1 0 -1 0 repelem(0,1,6)]];
t_contrast = [t_contrast_sub repelem(0,1,70) t_contrast_sub];
job{1}.spm.stats.con.consess{8}.tcon.name = 't contrast SIM>localizer';
job{1}.spm.stats.con.consess{8}.tcon.weights = t_contrast_sub;
job{1}.spm.stats.con.consess{8}.tcon.sessrep = 'none';


t_contrast_sub = [repmat((1/6)*[1 0 1 0 repelem(0,1,6)],1,6) [-1 0 -1 0 repelem(0,1,6)]];
%t_contrast_sub = [repmat([1 0 1 0 repelem(0,1,6)],1,6) [-1 0 -1 0 repelem(0,1,6)]];
t_contrast = [t_contrast_sub repelem(0,1,70) t_contrast_sub];
job{1}.spm.stats.con.consess{9}.tcon.name = 't contrast conditionAverage>localizer';
job{1}.spm.stats.con.consess{9}.tcon.weights = t_contrast_sub;
job{1}.spm.stats.con.consess{9}.tcon.sessrep = 'none';

t_contrast_sub = [repmat((1/6)*[-1 0 -1 0 repelem(0,1,6)],1,6) [1 0 1 0 repelem(0,1,6)]];
%t_contrast_sub = [repmat([1 0 1 0 repelem(0,1,6)],1,6) [-1 0 -1 0 repelem(0,1,6)]];
t_contrast = [t_contrast_sub repelem(0,1,70) t_contrast_sub];
job{1}.spm.stats.con.consess{10}.tcon.name = 't contrast localizer>conditionAverage';
job{1}.spm.stats.con.consess{10}.tcon.weights = t_contrast_sub;
job{1}.spm.stats.con.consess{10}.tcon.sessrep = 'none';


job{1}.spm.stats.con.delete = 1;

spm_jobman('run', job);


end