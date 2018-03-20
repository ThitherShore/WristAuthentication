clc;clear
load('letters.mat');
Letter=26;
N=19;
for i=1:Letter
    for j=1:N
        Train{i}{j}=V_smo{i}{j};
    end
    Test{i}=V_smo{i}{10};
end
for i=1:Letter
    Train{i}{10}=V_smo{i}{20};
end
for i=1:Letter
    for ii=1:Letter
        for j=1:N
            for k=1:6
                Sc{ii}((i-1)*N+j,k)=dtw(Train{ii}{j}(:,k),Test{i}(:,k));
            end
        end
    end
end
for i=1:26
    [E{i},F{i}]=sort(Sc{i});
    F{i}=ceil(F{i}/19);
end

K=19;
for i=1:26
    subplot(4,7,i)
    for k=1:6
        for j=1:K
            if F{i}(j,k)==i
                % plot(j*cos(2*pi*(k-1)/6),j*sin(2*pi*(k-1)/6),'r.');
                fill([(j-1)*cos(2*pi*(k-1)/6),(j)*cos(2*pi*(k-1)/6),(j)*cos(2*pi*(k)/6),(j-1)*cos(2*pi*(k)/6)],[(j-1)*sin(2*pi*(k-1)/6),(j)*sin(2*pi*(k-1)/6),(j)*sin(2*pi*(k)/6),(j-1)*sin(2*pi*(k)/6)],[21,168,255]/256,'edgealpha',0);
            else
                % plot(j*cos(2*pi*(k-1)/6),j*sin(2*pi*(k-1)/6),'b.');
                %fill([j*cos(2*pi*(k-1)/6),(j+1)*cos(2*pi*(k-1)/6),(j+1)*cos(2*pi*(k)/6),j*cos(2*pi*(k)/6)],[j*sin(2*pi*(k-1)/6),(j+1)*sin(2*pi*(k-1)/6),(j+1)*sin(2*pi*(k)/6),j*sin(2*pi*(k)/6)],'c','edgealpha',0);
            end
            hold on;
        end
    end
    for k=0:5
        plot([0,K*cos(2*pi*k/6)],[0,K*sin(2*pi*k/6)],'b-');
        hold on
        plot([K*cos(2*pi*(k-1)/6),K*cos(2*pi*k/6)],[K*sin(2*pi*(k-1)/6),K*sin(2*pi*k/6)],'b-');
        hold on
    end
    set(gca,'xtick',[],'xticklabel',[]);
    set(gca,'ytick',[],'yticklabel',[]);
    axis([-20 20 -10*sqrt(3) 10*sqrt(3)]);
    box on;
    title(char(i+96));
end

%% score calculate
% Score=zeros(26,26);
% for i=1:26
%     T=F{i}(1:19,:);
%     for j=1:26
%         Score(i,j)=length(find(T==j));
%     end
% end
% Score=Score';
% [S,Rank]=sort(Score,'descend');
% B=char(Rank+96);
% for i=1:26
%     Show(:,i)=Score(:,i)/max(Score(:,i));
% end
j=0;
x=[1,2,5,10,19,30,60,100,200];
for k=x
    j=j+1;
    [Score,Rank,B,Show]=Score_cal(F,k);
    subplot(3,3,j)
    Show=1-Show;
    imshow(Show);
    title(['k=',num2str(k)]);
end