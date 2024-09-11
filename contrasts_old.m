function contrasts(folder_path_glm)

job = [];
file_path_design = spm_select('FPList', folder_path_glm, '^SPM.mat$');
job{1}.spm.stats.con.spmmat = {file_path_design};


%% F Omnibus Contrasts
sub_all_runs_eye = eye(2*68);
for i=1:6
    sub_all_runs_eye(:,(i*10-6):(i*10)) = 0;
    sub_all_runs_eye(:,i*10-8) = 0;
end
sub_all_runs_eye(:,60:68)=0;

for i=1:6
    sub_all_runs_eye(:,(i*10-6+68):(i*10+68)) = 0;
    sub_all_runs_eye(:,i*10-8+68) = 0;
end
sub_all_runs_eye(:,end-8:end)=0;


job{1}.spm.stats.con.consess{1}.fcon.name = 'F bistable omnibus';
job{1}.spm.stats.con.consess{1}.fcon.weights = sub_all_runs_eye;
job{1}.spm.stats.con.consess{1}.fcon.sessrep = 'none';

job{1}.spm.stats.con.consess{2}.fcon.name = 'F bistable TM omnibus';
job{1}.spm.stats.con.consess{2}.fcon.weights = [repelem(0,136,1) sub_all_runs_eye(:,1:end-1)];
job{1}.spm.stats.con.consess{2}.fcon.sessrep = 'none';

sub_all_runs_eye = eye(2*68);
for i=1:6
    sub_all_runs_eye(:,(i*10-8):(i*10)) = 0;
    sub_all_runs_eye(:,i*10-8) = 0;
end
sub_all_runs_eye(:,60:68)=0;

for i=1:6
    sub_all_runs_eye(:,(i*10-8+68):(i*10+68)) = 0;
    sub_all_runs_eye(:,i*10-8+68) = 0;
end
sub_all_runs_eye(:,60+68:68+68)=0;

sub_all_runs_eye = sub_all_runs_eye + [repelem(0,136,2) sub_all_runs_eye(:,1:end-2)];

job{1}.spm.stats.con.consess{3}.fcon.name = 'F bistable omnibus cond averaged';
job{1}.spm.stats.con.consess{3}.fcon.weights = sub_all_runs_eye;
job{1}.spm.stats.con.consess{3}.fcon.sessrep = 'none';

job{1}.spm.stats.con.consess{4}.fcon.name = 'F bistable TM omnibus cond averaged';
job{1}.spm.stats.con.consess{4}.fcon.weights = [repelem(0,136,1) sub_all_runs_eye(:,1:end-1)];
job{1}.spm.stats.con.consess{4}.fcon.sessrep = 'none';


%% F Comparison Contrasts For Each Sub
sub_all_runs_eye = eye(68);
for i=1:6
    sub_all_runs_eye(:,(i*10-8):(i*10)) = 0;
end
sub_all_runs_eye(:,60:68)=0;
sub_all_runs_eye_fin = sub_all_runs_eye + [repelem(0,68,2) sub_all_runs_eye(:,1:end-2)];

job{1}.spm.stats.con.consess{5}.fcon.name = 'SUB001 F bistable cond averaged';
job{1}.spm.stats.con.consess{5}.fcon.weights = sub_all_runs_eye_fin;
job{1}.spm.stats.con.consess{5}.fcon.sessrep = 'none';

job{1}.spm.stats.con.consess{6}.fcon.name = 'SUB002 F bistable cond averaged';
job{1}.spm.stats.con.consess{6}.fcon.weights = [zeros(68) sub_all_runs_eye_fin];
job{1}.spm.stats.con.consess{6}.fcon.sessrep = 'none';


sub_all_runs_eye_fin = sub_all_runs_eye + -1*[repelem(0,68,2) sub_all_runs_eye(:,1:end-2)];
job{1}.spm.stats.con.consess{7}.fcon.name = 'SUB001 F bistable ALT-SIM';
job{1}.spm.stats.con.consess{7}.fcon.weights = sub_all_runs_eye_fin;
job{1}.spm.stats.con.consess{7}.fcon.sessrep = 'none';

job{1}.spm.stats.con.consess{8}.fcon.name = 'SUB002 F bistable ALT-SIM';
job{1}.spm.stats.con.consess{8}.fcon.weights = [zeros(68) sub_all_runs_eye_fin];
job{1}.spm.stats.con.consess{8}.fcon.sessrep = 'none';


sub_all_runs_eye_fin = -1*sub_all_runs_eye + [repelem(0,68,2) sub_all_runs_eye(:,1:end-2)];
job{1}.spm.stats.con.consess{9}.fcon.name = 'SUB001 F bistable SIM-ALT';
job{1}.spm.stats.con.consess{9}.fcon.weights = sub_all_runs_eye_fin;
job{1}.spm.stats.con.consess{9}.fcon.sessrep = 'none';

job{1}.spm.stats.con.consess{10}.fcon.name = 'SUB002 F bistable SIM-ALT';
job{1}.spm.stats.con.consess{10}.fcon.weights = [zeros(68) sub_all_runs_eye_fin];
job{1}.spm.stats.con.consess{10}.fcon.sessrep = 'none';


%% F TM Comparison Contrasts For Each Sub
sub_all_runs_eye = eye(68);
for i=1:6
    sub_all_runs_eye(:,(i*10-8):(i*10)) = 0;
end
sub_all_runs_eye(:,60:68)=0;
sub_all_runs_eye = [repelem(0,68,1) sub_all_runs_eye(:,1:end-1)];
sub_all_runs_eye_fin = sub_all_runs_eye + [repelem(0,68,2) sub_all_runs_eye(:,1:end-2)];

job{1}.spm.stats.con.consess{11}.fcon.name = 'SUB001 F bistable cond TM averaged';
job{1}.spm.stats.con.consess{11}.fcon.weights = sub_all_runs_eye_fin;
job{1}.spm.stats.con.consess{11}.fcon.sessrep = 'none';

job{1}.spm.stats.con.consess{12}.fcon.name = 'SUB002 F bistable cond TM averaged';
job{1}.spm.stats.con.consess{12}.fcon.weights = [zeros(68) sub_all_runs_eye_fin];
job{1}.spm.stats.con.consess{12}.fcon.sessrep = 'none';


sub_all_runs_eye_fin = sub_all_runs_eye + -1*[repelem(0,68,2) sub_all_runs_eye(:,1:end-2)];
job{1}.spm.stats.con.consess{13}.fcon.name = 'SUB001 F bistable TM ALT-SIM';
job{1}.spm.stats.con.consess{13}.fcon.weights = sub_all_runs_eye_fin;
job{1}.spm.stats.con.consess{13}.fcon.sessrep = 'none';

job{1}.spm.stats.con.consess{14}.fcon.name = 'SUB002 F bistable TM ALT-SIM';
job{1}.spm.stats.con.consess{14}.fcon.weights = [zeros(68) sub_all_runs_eye_fin];
job{1}.spm.stats.con.consess{14}.fcon.sessrep = 'none';


sub_all_runs_eye_fin = -1*sub_all_runs_eye + [repelem(0,68,2) sub_all_runs_eye(:,1:end-2)];
job{1}.spm.stats.con.consess{15}.fcon.name = 'SUB001 F bistable TM SIM-ALT';
job{1}.spm.stats.con.consess{15}.fcon.weights = sub_all_runs_eye_fin;
job{1}.spm.stats.con.consess{15}.fcon.sessrep = 'none';

job{1}.spm.stats.con.consess{16}.fcon.name = 'SUB002 F bistable TM SIM-ALT';
job{1}.spm.stats.con.consess{16}.fcon.weights = [zeros(68) sub_all_runs_eye_fin];
job{1}.spm.stats.con.consess{16}.fcon.sessrep = 'none';

%% F Comparison but averaged over runs
f_contrast = [repmat([1 0 1 0 repelem(0,1,6)],1,6) repelem(0,1,8)];
job{1}.spm.stats.con.consess{17}.fcon.name = 'SUB001 F bistable cond averaged run averaged';
job{1}.spm.stats.con.consess{17}.fcon.weights = f_contrast;
job{1}.spm.stats.con.consess{17}.fcon.sessrep = 'none';

job{1}.spm.stats.con.consess{18}.fcon.name = 'SUB002 F bistable cond averaged run averaged';
job{1}.spm.stats.con.consess{18}.fcon.weights = [repelem(0,1,68) f_contrast];
job{1}.spm.stats.con.consess{18}.fcon.sessrep = 'none';


f_contrast = [repmat([1 0 -1 0 repelem(0,1,6)],1,6) repelem(0,1,8)];
job{1}.spm.stats.con.consess{19}.fcon.name = 'SUB001 F bistable run averaged ALT-SIM';
job{1}.spm.stats.con.consess{19}.fcon.weights = f_contrast;
job{1}.spm.stats.con.consess{19}.fcon.sessrep = 'none';

job{1}.spm.stats.con.consess{20}.fcon.name = 'SUB002 F bistable run averaged ALT-SIM';
job{1}.spm.stats.con.consess{20}.fcon.weights = [repelem(0,1,68) f_contrast];
job{1}.spm.stats.con.consess{20}.fcon.sessrep = 'none';


f_contrast = [repmat([-1 0 1 0 repelem(0,1,6)],1,6) repelem(0,1,8)];
job{1}.spm.stats.con.consess{21}.fcon.name = 'SUB001 F bistable run averaged SIM-ALT';
job{1}.spm.stats.con.consess{21}.fcon.weights = f_contrast;
job{1}.spm.stats.con.consess{21}.fcon.sessrep = 'none';

job{1}.spm.stats.con.consess{22}.fcon.name = 'SUB002 F bistable run averaged SIM-ALT';
job{1}.spm.stats.con.consess{22}.fcon.weights = [repelem(0,1,68) f_contrast];
job{1}.spm.stats.con.consess{22}.fcon.sessrep = 'none';


%% T Comparison Contrasts for Each Subject

%t_contrast = [repmat([1 0 repelem(0,1,8)],1,6) repelem(0,1,8)];

%job{1}.spm.stats.con.consess{17}.tcon.name = 'SUB001 T bistable cond averaged';
%job{1}.spm.stats.con.consess{17}.tcon.weights = t_contrast;
%job{1}.spm.stats.con.consess{17}.tcon.sessrep = 'none';


job{1}.spm.stats.con.delete = 1;

spm_jobman('run', job);


end