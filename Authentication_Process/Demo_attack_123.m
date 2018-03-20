run('Data_generate.m');
for i=1:10
    Train{i}=Data_a_smo{i*5};
end
j=1;
bes=bestdist(Train);
for i=1:40
    if mod(j,5)==0
        j=j+1;
    end
    [score_a(i),~,totalscore_a(i)]=judgement_withbes(Train,Data_a_smo{j},bes);
    j=j+1;
end
for i=41:50
    [score_a(i),~,totalscore_a(i)]=judgement_withbes(Train,Data_a_test_smo{i-40},bes);
end
for i=2:6
    for j=1:5
    [score_a1((i-2)*5+j),~,totalscore_a1((i-2)*5+j)]=judgement_withbes(Train,Self{i}{j},bes);
    end
end
B=data_import('my_sensor_data_love_hack1.txt');
for i=1:10
    for k=1:6
        B_smo{i}(:,k)=smooth(B{i}(:,k),9,'sgolay',2);
    end
end
for i=1:10
    [score_b(i),~,totalscore_b(i)]=judgement_withbes(Train,B_smo{i},bes);
end
for i=11:20
     [score_b(i),~,totalscore_b(i)]=judgement_withbes(Train,Data_atk2_smo{i-10},bes);
end
for i=1:10
    [score_c(i),~,totalscore_c(i)]=judgement_withbes(Train,Data_atk3_smo{i},bes);
end
for i=11:40
    [score_c(i),~,totalscore_c(i)]=judgement_withbes(Train,Data_attack_smo{11+i},bes);
end
a=totalscore_a';
a1=totalscore_a1';
b=totalscore_b';
c=totalscore_c';
hold on
boxplot(a,'width',0.4,'positions',1);
plot(1,mean(a),'r.');
hold on
boxplot(a1,'width',0.4,'positions',2);
plot(2,mean(a1),'r.');
hold on
boxplot(b,'width',0.4,'positions',3);
plot(3,mean(b),'r.');
hold on
boxplot(c,'width',0.4,'positions',4);
plot(4,mean(c),'r.');
axis([0.5 4.5 0 1]);
ylabel('TSS');
figure;
subplot(121);
plot(Train{3}(:,1));
hold on
plot(Data_atk3_smo{3}(:,1),'r-');
xlabel('Time');
ylabel('a_x');
legend('Authorized trail','All-simulate trail');
subplot(122);
plot(Train{3}(:,4));
hold on
plot(Data_atk3_smo{3}(:,4),'r-');
xlabel('Time');
ylabel('\omega_x');
legend('Authorized trail','All-simulate trail');