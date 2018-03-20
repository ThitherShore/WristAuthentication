run('Data_generate.m');
[P0,pos0,X0]=data_import('my_sensor_data_love_0_1.txt');
[P1,pos1,X1]=data_import('my_sensor_data_love_withoutpen.txt');
[P2,pos2,X2]=data_import('my_sensor_data_mind_withoutpen.txt');
[P22,pos22,X22]=data_import('my_sensor_data_mind_withoutpen1.txt');
[P3,pos3,X3]=data_import('my_sensor_data_even_withoutpen.txt');
[P33,pos33,X33]=data_import('my_sensor_data_even_withoutpen1.txt');
for i=1:10
    for k=1:6
        P0_smo{i}(:,k)=smooth(P0{i}(:,k),9,'sgolay',2);
    end
end
for i=1:5
    P2{i+5}=P22{i};
end
P3{10}=P33{2};
for i=1:10
    for k=1:6
        P1_smo{i}(:,k)=smooth(P1{i}(:,k),9,'sgolay',2);
        P2_smo{i}(:,k)=smooth(P2{i}(:,k),9,'sgolay',2);
        P3_smo{i}(:,k)=smooth(P3{i}(:,k),9,'sgolay',2);
    end
end
Tr1=Train;
Tr2=Data_b_smo{3};
Tr3=Data_b_smo{8};
for i=1:10
    [~,~,ts0(i)]=judgement(Tr1,P0_smo{i});
    [~,~,ts1(i)]=judgement(Tr1,P1_smo{i});
    [~,~,ts2(i)]=judgement(Tr2,P2_smo{i});
    [~,~,ts3(i)]=judgement(Tr3,P3_smo{i});
end
% boxplot(ts0,'position',1,'width',0.4);
% hold on
% plot(1,mean(ts0),'r.','markersize',10);
% boxplot(totalscore_b(:),'position',2,'width',0.4);
% hold on
% plot(2,mean(totalscore_b(:)),'r.','markersize',10);
% boxplot(ts1,'position',3,'width',0.4);
% hold on
% plot(3,mean(ts1),'r.','markersize',10);
% boxplot(c,'position',4,'width',0.4);
% plot(4,mean(c),'r.','markersize',10);
% axis([0.5 4.5 0 1]);
% ylabel('TSS');

boxplot(ts1,'position',1,'width',0.4);
hold on
plot(1,mean(ts1),'r.','markersize',10);
boxplot(ts2,'position',2,'width',0.4);
hold on
plot(2,mean(ts2),'r.','markersize',10);
boxplot(ts3,'position',3,'width',0.4);
hold on
plot(3,mean(ts3),'r.','markersize',10);
axis([0.5 3.5 0 1]);
ylabel('TSS');