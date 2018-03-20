clear;
[Data_p,pos_p,X_p]=data_import('my_sensor_data_pattern.txt');
[Data_p_atk1,pos_p_1,X_p_1]=data_import('my_sensor_data_pattern_attack_1.txt');
[Data_p_atk22,pos_p_22,X_p_22]=data_import('my_sensor_data_pattern_attack_2.txt');
[Data_p_atk33,pos_p_33,X_p_33]=data_import('my_sensor_data_pattern_attack_3.txt');
[Data_s,pos_s,X_s]=data_import('my_sensor_data_signature.txt');
[Data_s_atk1,pos_s_atk1,X_s_atk1]=data_import('my_sensor_data_signature_attack_1.txt');
[Data_s_atk2,pos_s_atk2,X_s_atk2]=data_import('my_sensor_data_signature_attack_2.txt');
for i=1:5
    Data_p_atk2{i}=Data_p_atk22{i};
end
for i=6:10
    Data_p_atk2{i}=Data_p_atk22{i-5};
end
for i=1:10
    for k=1:6
        Data_p_smo{i}(:,k)=smooth(Data_p{i}(:,k),9,'sgolay',2);
        Data_p_atk1_smo{i}(:,k)=smooth(Data_p_atk1{i}(:,k),9,'sgolay',2);
        Data_p_atk2_smo{i}(:,k)=smooth(Data_p_atk2{i}(:,k),9,'sgolay',2);
        Data_s_smo{i}(:,k)=smooth(Data_s{i}(:,k),9,'sgolay',2);
        Data_s_atk1_smo{i}(:,k)=smooth(Data_s_atk1{i}(:,k),9,'sgolay',2);
        Data_s_atk2_smo{i}(:,k)=smooth(Data_s_atk2{i}(:,k),9,'sgolay',2);
    end
end
for i=1:5
    Tr_p{i}=Data_p_smo{i};
    Tr_s{i}=Data_s_smo{i};
end
bes_p=bestdist(Tr_p);
bes_s=bestdist(Tr_s);
for i=1:5
    [~,~,ts_p(i)]=judgement_withbes(Tr_p,Data_p_smo{i+5},bes_p);
end
for i=1:10
    [~,~,ts_p1(i)]=judgement_withbes(Tr_p,Data_p_atk1_smo{i},bes_p);
    [~,~,ts_p2(i)]=judgement_withbes(Tr_p,Data_p_atk2_smo{i},bes_p);
end

for i=1:5
    [~,~,ts_s(i)]=judgement_withbes(Tr_s,Data_s_smo{i+5},bes_s);
end
for i=1:10
    [~,~,ts_s1(i)]=judgement_withbes(Tr_s,Data_s_atk1_smo{i},bes_s);
    [~,~,ts_s2(i)]=judgement_withbes(Tr_s,Data_s_atk2_smo{i},bes_s);
end

a=ts_p;
b=ts_p1;
c=ts_p2;

hold on
boxplot(a,'width',0.4,'positions',1);
plot(1,mean(a),'r.');
hold on
boxplot(b,'width',0.4,'positions',2);
plot(2,mean(b),'r.');
hold on
boxplot(c,'width',0.4,'positions',3);
plot(3,mean(c),'r.');
axis([0.5 3.5 0 1]);
title('Signature');
ylabel('TSS');

figure;
a=ts_s;
b=ts_s1;
c=ts_s2;

hold on
boxplot(a,'width',0.4,'positions',1);
plot(1,mean(a),'r.');
hold on
boxplot(b,'width',0.4,'positions',2);
plot(2,mean(b),'r.');
hold on
boxplot(c,'width',0.4,'positions',3);
plot(3,mean(c),'r.');
axis([0.5 3.5 0 1]);
title('Pattern');
ylabel('TSS');
