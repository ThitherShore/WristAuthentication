function [res,score,totalscore]=judgement_withbes_forall_1(A,U,bes,thr)
    %res=0 means no matching while res=1 means matching.
    rho=[0.0111,0.1249,0.2945,0.2655,0.2679,0.0361];
    n=length(A);
    del=zeros(1,n);
    lambda=round(n/4);
     for i=1:n
         del(i)=poisspdf(i,lambda);
     end
     del=del/sum(del);

    D=bes;
    score=zeros(1,6);
    totalscore=0;
%    delta=0;
    for k=1:6
        UU=U(:,k);
        for i=1:length(A)
            P=size(A{i});
            PP=P(1);
            L=dtw(A{i}(:,k),UU,k);
            if L<D(k)
                temp(i)=1;
            else
                temp(i)=((D(k)-1/2*D(k))/(L-1/2*D(k)));
            end
            if temp(i)<0
                temp(i)=0;
            end
           % temp(i)=temp(i)^2;
        end
        temp=sort(temp);
        for i=1:length(A)
            score(k)=score(k)+del(length(A)+1-i)*temp(i);
        end
    end
    [A,B]=sort(score);
%        if(B(1)<=3)
%             rho(B(1))=0;
%             rho(mod(B(1),3)+1)=rho1/2;
%             rho(mod(B(1)+1,3)+1)=rho1/2;
%         else
%             rho(B(1))=0;
%             rho(mod(B(1),3)+1+3)=rho2/2;
%             rho(mod(B(1)+1,3)+1+3)=rho2/2;
%        end 
    for i=1:length(A)
        totalscore=totalscore+rho(i)*score(i);
    end
    %if delta==1
    %    totalscore=1;
    %end
    if totalscore>thr
        res=1;
    else
        res=0;
    end
end