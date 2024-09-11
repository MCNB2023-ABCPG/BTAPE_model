function contrasts(folder_path_glm)

job = [];
file_path_design = spm_select('FPList', folder_path_glm, '^SPM.mat$');
job{1}.spm.stats.con.spmmat = {file_path_design};



%% F Omnibus Contrasts
sub_all_runs_eye = eye(n_sub*68);


for s=0:2
    for i=1:6
        sub_all_runs_eye(:,(i*10-6+s*68):(i*10)) = 0;
        sub_all_runs_eye(:,i*10-8) = 0;
    end
    sub_all_runs_eye(:,s*68-8:68)=0;
    
    for i=1:6
        sub_all_runs_eye(:,(i*10-6+2*68):(i*10+2*68)) = 0;
        sub_all_runs_eye(:,i*10-8+2*68) = 0;
    end
    sub_all_runs_eye(:,end-8:2*68)=0;
    
    for i=1:6
        sub_all_runs_eye(:,(i*10-6+68):(i*10+68)) = 0;
        sub_all_runs_eye(:,i*10-8+68) = 0;
    end
    sub_all_runs_eye(:,end-8:end)=0;

end


job{1}.spm.stats.con.consess{1}.fcon.name = 'F bistable omnibus';
job{1}.spm.stats.con.consess{1}.fcon.weights = sub_all_runs_eye;
job{1}.spm.stats.con.consess{1}.fcon.sessrep = 'none';

job{1}.spm.stats.con.consess{2}.fcon.name = 'F bistable TM omnibus';
job{1}.spm.stats.con.consess{2}.fcon.weights = [repelem(0,136,1) sub_all_runs_eye(:,1:end-1)];
job{1}.spm.stats.con.consess{2}.fcon.sessrep = 'none';


job{1}.spm.stats.con.delete = 1;

spm_jobman('run', job);


end