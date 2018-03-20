clear;
N=26;
for i=1:N
    [V1{i},pos{i},X{i}]=data_letter_import(['my_sensor_data_',num2str(i),'_new.txt']);
end
aver=zeros(1,26);
for i=1:N
    for j=1:length(V1{i})
        aver(i)=aver(i)+length(V1{i}{j});
    end
    aver(i)=aver(i)/length(V1{i});
end
for i=1:N
    k=1;
    for j=1:length(V1{i})
        if length(V1{i}{j})>aver(i)-15
            V{i}{k}=V1{i}{j};
            k=k+1;
        end
    end
end

for i=1:N
    for j=1:20
        V_smo{i}{j}=data_letter_smooth(V{i}{j},7);
    end
end

for i=1:N
    for j=1:20
        for k=1:6
            avg{i}{j}{k}=mean(abs(V_smo{i}{j}(:,k)));
        end
    end
end

avg_all=zeros(1,6);
for k=1:6
    for i=1:N
        for j=1:20
            avg_all(k)=avg_all(k)+avg{i}{j}{k};
        end
    end
    avg_all(k)=avg_all(k)/20/N;
end



Fea=[];
k=0;
for i=1:26
    for j=1:20
        k=k+1;
        X=zscore(V{i}{j});
        %X=V_smo{i}{j};
        F1=mean(X);
        F2=min(X);
        F3=max(X);
        F4=F3-F2;
        F5=var(X);
        F6=kurtosis(X);
        F7=skewness(X);
        Y=fft(X);
        Y1=abs(Y);
        Y1=Y1.^2;
        F8=sum(Y1);
        Y2=log(Y1+1);
        Y3=Y1.*Y2;
        F9=sum(Y3);
        FF1=Distribution_Build(X);
        FF2=Peaks_Build(X);
        %F=[F1';F2';F3';F4';F5';F6';F7';F8';F9';FF1;FF2];
        F=[FF1;FF2];
        Fea(:,k)=F;
    end
end

k=1;
for i=1:26
    for j=1:20
        L(k)=length(V_smo{i}{j});
        k=k+1;
    end
end
hist(L(L<=80));
xlabel('Letter Length / 62^{-1}s');
ylabel('Counts');
