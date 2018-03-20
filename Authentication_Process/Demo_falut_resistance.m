run('Data_generate.m');
for i=1:10
    Train{i}=Data_a_smo{i*5-4};
end
j=1;
for i=1:40
    if  mod(i,1)==1  j=j+1;  end
    Test1{i}=Data_a_smo{j};
    j=j+1;
end

for i=1:50
    Test2{i}=Data_b_smo{ceil(i/10)+4}{mod(i-1,10)+1};
end

tpr=zeros(1,41);
fnr=zeros(1,41);
for K=0:40
    K
    bes{K+1}=bestdist(Train);
    if K>0
        Train{K+10}=Data_b_smo{ceil(K/10)}{mod(K-1,10)+1};
    end
    for i=1:40
        tpr(K+1)=tpr(K+1)+judgement_withbes(Train,Test1{i},bes{K+1})/40;
    end
    for i=1:50
        fnr(K+1)=fnr(K+1)+judgement_withbes(Train,Test2{i},bes{K+1})/50;
    end
end
plot(tpr,'linewidth',1.1)
hold on
plot(fnr,'g-','linewidth',1.1)
plot(tpr,'r.','markersize',10)
plot(fnr,'r.','markersize',10)
legend('True positive rate','False negative rate');
xlabel('Wrond trails')
ylabel('Rate')