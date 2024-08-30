function contrasts(folder_path_glm)

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


sub_all_runs_eye = eye(68);
sub_all_runs_eye(:,1:60)=0;
sub_all_runs_eye(:,63:end)=0;
job{1}.spm.stats.con.consess{17}.fcon.name = 'sub001 LOCALIZER F';
job{1}.spm.stats.con.consess{17}.fcon.weights = [sub_all_runs_eye zeros(68)];
job{1}.spm.stats.con.consess{17}.fcon.sessrep = 'none';

job{1}.spm.stats.con.consess{18}.fcon.name = 'sub002 LOCALIZER F';
job{1}.spm.stats.con.consess{18}.fcon.weights = [zeros(68) sub_all_runs_eye];
job{1}.spm.stats.con.consess{18}.fcon.sessrep = 'none';


sub_all_runs_eye = eye(68);
sub_all_runs_eye(:,1)=0;
for i=1:6
    sub_all_runs_eye(:,(i*10-7):(i*10+1)) = 0;
end
sub_all_runs_eye(:,end-8:end)=0;
job{1}.spm.stats.con.consess{19}.fcon.name = 'sub001 TMOD ALT F';
job{1}.spm.stats.con.consess{19}.fcon.weights = sub_all_runs_eye;
job{1}.spm.stats.con.consess{19}.fcon.sessrep = 'none';


job{1}.spm.stats.con.consess{20}.fcon.name = 'sub002 TMOD ALT F';
job{1}.spm.stats.con.consess{20}.fcon.weights = [zeros(68) sub_all_runs_eye];
job{1}.spm.stats.con.consess{20}.fcon.sessrep = 'none';


sub_all_runs_eye = eye(68);
sub_all_runs_eye(:,1:3)=0;
for i=1:6
    sub_all_runs_eye(:,(i*10-5):(i*10+3)) = 0;
end
sub_all_runs_eye(:,end-8:end)=0;

job{1}.spm.stats.con.consess{21}.fcon.name = 'sub001 TMOD SIM F';
job{1}.spm.stats.con.consess{21}.fcon.weights = sub_all_runs_eye;
job{1}.spm.stats.con.consess{21}.fcon.sessrep = 'none';


job{1}.spm.stats.con.consess{22}.fcon.name = 'sub002 TMOD SIM F';
job{1}.spm.stats.con.consess{22}.fcon.weights = [zeros(68) sub_all_runs_eye];
job{1}.spm.stats.con.consess{22}.fcon.sessrep = 'none';


job{1}.spm.stats.con.delete = 1;

spm_jobman('run', job);


end