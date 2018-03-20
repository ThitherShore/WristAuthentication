run('Data_generate.m');
Data_aa=data_import('my_sensor_data_love_0_3.txt');
for i=1:length(Data_aa)
    for k=1:6
        Data_aa_smo{i}(:,k)=smooth(Data_aa{i}(:,k),9,'sgolay',2);
    end
end
j=1;k=1;
for i=1:50
    if mod(i,5)==0
        Tr{j}=Data_a_smo{i};
        j=j+1;
    else 
        D1{k}=Data_a_smo{i};
        k=k+1;
    end
end
for i=1:10
    D1{k}=Data_a_test_smo{i};
    k=k+1;
end
k=1;
for i=1:10
    for j=1:3
        D2{i*3-3+j}=Data_b_smo{i}{3*j};
    end
end
for i=31:100
    D2{i}=Data_attack_smo{i-30};
end

bes=bestdist(Tr);
tpr=zeros(1,21);
fpr=zeros(1,21);
i=1;
thr=0;
while thr<=1
    thr
    for j=1:50
        tpr(i)=tpr(i)+judgement_withbes_forall(Tr,D1{j},bes,thr)/50;
    end
    for j=1:100
        fpr(i)=fpr(i)+judgement_withbes_forall(Tr,D2{j},bes,thr)/100;
    end
    thr=thr+0.05;
    i=i+1;
end
S=polyarea([tpr,0,1],[fpr,1,1]);

bes2=bestdist(Tr);
tpr2=zeros(1,21);
fpr2=zeros(1,21);
i=1;
thr=0;
while thr<=1
    thr
    for j=1:50
        tpr2(i)=tpr2(i)+judgement_withbes_forall_1(Tr,D1{j},bes,thr)/50;
    end
    for j=1:100
        fpr2(i)=fpr2(i)+judgement_withbes_forall_1(Tr,D2{j},bes,thr)/100;
    end
    thr=thr+0.05;
    i=i+1;
end
S2=polyarea([tpr2,0,1],[fpr2,1,1]);

S
S2
