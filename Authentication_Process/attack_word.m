run('Data_generate.m');
for i=1:length(Data_c_smo)
    [~,~,ts(i)]=judgement(Train,Data_c_smo{i});
end