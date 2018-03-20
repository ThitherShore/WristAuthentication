function [Score,Rank,B,Show]=Score_cal(F,k)
Score=zeros(26,26);
for i=1:26
    T=F{i}(1:k,:);
    for j=1:26
        Score(i,j)=length(find(T==j));
    end
end
Score=Score';
[S,Rank]=sort(Score,'descend');
B=char(Rank+96);
for i=1:26
    Show(:,i)=Score(:,i)/max(Score(:,i));
end
end