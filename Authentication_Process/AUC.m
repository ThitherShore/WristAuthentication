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
tpr=zeros(6,21);
fpr=zeros(6,21);
for Z=1:6
    i=1;
    thr=0;
    Z
    while thr<=1
        for j=1:50
            tpr(Z,i)=tpr(Z,i)+judgement_withbes_for_k(Tr,D1{j},bes,Z,thr)/50;
        end
        for j=1:100
            fpr(Z,i)=fpr(Z,i)+judgement_withbes_for_k(Tr,D2{j},bes,Z,thr)/100;
        end
        thr=thr+0.05;
        i=i+1;
    end
end
for i=1:6
    subplot(2,3,i);
    plot(fpr(i,:),tpr(i,:));
    hold on
    plot(fpr(i,:),tpr(i,:),'r.','markersize',10);
    S(i)=polyarea([tpr(i,:),0,1],[fpr(i,:),1,1]);
    xlabel('FPR');
    ylabel('TPR');
    axis([0 1.2 0 1.2])
    plot([1,1],[0,1],'g--');
    if i==1
        Str='a_x';
    elseif i==2
        Str='a_y';
    elseif i==3
        Str='a_z';
    elseif i==4
        Str='\omega_x';
    elseif i==5
        Str='\omega_y';
    elseif i==6
        Str='\omega_z';
    end
    title(Str);
end