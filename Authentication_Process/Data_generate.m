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
for i=1:50
    for k=1:6
        Data_a_smo{i}(:,k)=smooth(Data_a{i}(:,k),9,'sgolay',2);
    end
end
for i=1:10
    for j=1:10
        for k=1:6
            Data_b_smo{i}{j}(:,k)=smooth(Data_b{i}{j}(:,k),9,'sgolay',2);
        end
    end
end
for i=1:10
    Train{i}=Data_a_smo{5*i};
end
for i=1:10
    [Data_c0{i},pos{i},X{i}]=data_import(['my_sensor_data_love',num2str(i+1),'.txt']);
end
k=1;
cc=zeros(10,1);
for i=1:10
    for j=1:length(Data_c0{i})
        if length(Data_c0{i}{j})>100
            Data_c{k}=Data_c0{i}{j};
            k=k+1;
            cc(i)=cc(i)+1;
        end
    end
end
K=length(Data_c);
for i=1:K
    for k=1:6
        Data_c_smo{i}(:,k)=smooth(Data_c{i}(:,k),9,'sgolay',2);
    end
end
k=1;
delta=0;
for i=2:10
    delta=0;
    if cc(i)>=5
        for j=1:5
            Self{k}{j}=Data_c_smo{sum(cc(1:i-1))+j};
            delta=1;
        end
    end
    if delta==1
        k=k+1;
    end
end

[Data_atk2,pos_atk2,X_atk2]=data_import('my_sensor_data_attack2.txt');
Data_atk2{9}=X_atk2(4035:4262,:);
Data_atk2{10}=X_atk2(4522:4741,:);
[Data_atk3,pos_atk3,X_atk3]=data_import('my_sensor_data_attack3.txt');
for i=1:10
    for k=1:6
    Data_atk2_smo{i}(:,k)=smooth(Data_atk2{i}(:,k),9,'sgolay',2);
    Data_atk3_smo{i}(:,k)=smooth(Data_atk3{i}(:,k),9,'sgolay',2);
    end
end
Data_atk{1}=Data_atk2;
Data_atk{2}=Data_atk3;
for i=3:9
    [Data_atk{i},Pos_atk{i},X_atk{i}]=data_import(['my_sensor_data_atk',num2str(i-2),'.txt']);
end
k=1;
for i=1:9
    for j=1:length(Data_atk{i})
        if length(Data_atk{i}{j})>100
            Data_attack{k}=Data_atk{i}{j};
            k=k+1;
        end
    end
end
k=k-1;
for i=1:k
    for j=1:6
        Data_attack_smo{i}(:,j)=smooth(Data_attack{i}(:,j),9,'sgolay',2);
    end
end
[Data_a_test,Pos_a_test,X_a_test]=data_import('my_sensor_data_love_test1.txt');
for i=1:10
    for j=1:6
        Data_a_test_smo{i}(:,j)=smooth(Data_a_test{i}(:,j),9,'sgolay',2);
    end
end
for i=1:3
    [Data_a_change{i},Pos_a_change{i},X_a_change{i}]=data_import(['my_sensor_data_change_',num2str(i),'.txt']);
end
for i=1:3
    for k=1:length(Data_a_change{i})
        for j=1:6
            Data_a_change_smo{i}{k}(:,j)=smooth(Data_a_change{i}{k}(:,j),9,'sgolay',2);
        end
    end
end