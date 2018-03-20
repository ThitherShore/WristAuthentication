function [res,score]=judgement_withbes_for_k(A,U,bes,k,thr)
    %res=0 means no matching while res=1 means matching.
    n=length(A);
    del=zeros(1,n);
    lambda=round(n/4);
     for i=1:n
         del(i)=poisspdf(i,lambda);
     end
     del=del/sum(del);

    D=bes;
    score=0;
%    delta=0;

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
        end
        temp=sort(temp);
        for i=1:length(A)
            score=score+del(length(A)+1-i)*temp(i);
        end
    if score>thr
        res=1;
    else
        res=0;
    end
end