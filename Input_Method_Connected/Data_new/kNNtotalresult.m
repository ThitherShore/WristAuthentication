for k=1:20
    k
    Rank{k}=knn(k);
end
SR=zeros(20,26);
for i=1:20
    for j=1:26
        SR(i,j)=find(Rank{i}(:,j)==j);
    end
end
rate(1)=length(find(SR==1))/520;
rate(2)=length(find(SR<=2))/520;
rate(3)=length(find(SR<=3))/520;

boxplot(SR);
hold on
for i=1:26
    for j=1:20
        x=SR(:,i);
        y=length(find(x==j));
        if y~=0
            plot(i,j,'r.','markersize',7);
            hold on
            text(i,j-.19,num2str(y));
            hold on
        end
    end
end
xlabel('Letters');
ylabel('Rank');