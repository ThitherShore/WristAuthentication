clear;
[Data_b{1},pos_b{1},X_b{1}]=data_import('my_sensor_data_want.txt');
[Data_b{2},pos_b{2},X_b{2}]=data_import('my_sensor_data_stop.txt');
[Data_b{3},pos_b{3},X_b{3}]=data_import('my_sensor_data_mind.txt');
[Data_b{4},pos_b{4},X_b{4}]=data_import('my_sensor_data_moon.txt');
[Data_b{5},pos_b{5},X_b{5}]=data_import('my_sensor_data_game.txt');
[Data_b{6},pos_b{6},X_b{6}]=data_import('my_sensor_data_laugh.txt');
[Data_b{7},pos_b{7},X_b{7}]=data_import('my_sensor_data_high.txt');
Data_b{7}{10}=X_b{7}(5034:5257,:);
[Data_b{8},pos_b{8},X_b{8}]=data_import('my_sensor_data_even.txt');
[Data_b{9},pos_b{9},X_b{9}]=data_import('my_sensor_data_bet.txt');
[Data_b{10},pos_b{10},X_b{10}]=data_import('my_sensor_data_book.txt');
[Data_a_pre{1},pos_a{1},X_a{1}]=data_import('my_sensor_data_love_0_1.txt');
[Data_a_pre{2},pos_a{2},X_a{2}]=data_import('my_sensor_data_love_0_2.txt');
for i=1:19
Data_a{i}=Data_a_pre{1}{i};
end
for i=1:31
Data_a{i+19}=Data_a_pre{2}{i};
end
for i=1:10
    for j=1:10
        for k=1:6
            Data_b_smo{i}{j}(:,k)=smooth(Data_b{i}{j}(:,k),9,'sgolay',2);
        end
    end
end
for i=1:50
    for k=1:6
        Data_a_smo{i}(:,k)=smooth(Data_a{i}(:,k),9,'sgolay',2);
    end
end
for k=0:9
    for i=1:5
        Train{i}=Data_a_smo{i*10-k};
    end
    bes=bestdist(Train);
    for i=1:50
        [~,~,totalscore_a(k+1,i)]=judgement_withbes(Train,Data_a_smo{i},bes);
    end
    for i=1:10
        ['i=',num2str(i),'...']
        for j=1:10
            [~,~,totalscore_b(k+1,i,j)]=judgement_withbes(Train,Data_b_smo{i}{j},bes);
        end
    end
end
for k=1:10
    u=find(totalscore_a(k,:)<0.55);
    fnr(k)=length(u)/45;
    v=find(totalscore_b(k,:,:)>0.55);
    pnr(k)=length(v)/100;
end
fnr=fnr';
pnr=pnr';
X=[fnr,pnr];
boxplot(X);
axis([0.5 2.5 0 1]);
ylabel('Rate');
hold on
plot(1,mean(fnr),'r.');
plot(2,mean(pnr),'r.');