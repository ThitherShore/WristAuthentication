function [DD,Pos_w]=data_letter_sort(MM,typ)
    for i=1:15
        for j=1:6
            MM(i,j)=0;
        end
    end
    M=MM(:,1);
    M(1:5)=0;
    Pos=[];
    k=1;
    in=0.04;
    de=[0.02 0.02 0.02 20 12 12];
    for i=1:length(M)
        if abs(M(i))>in
            Ms(k)=i;
            k=k+1;
        end
    end
    k=k-1;
    M1=diff(Ms);
    [U,V]=sort(M1);
    j=1;
    for i=1:length(U)
        if U(i)>30
            RRank(j)=V(i);
            j=j+1;
        end
    end
    RRank=sort(RRank);
    j=2;
    Pos(1)=Ms(1);
    for i=1:length(RRank)
        Pos(j)=Ms(RRank(i));
        j=j+1;
        Pos(j)=Ms(RRank(i)+1);
        j=j+1;
    end
    Pos(j)=Ms(length(Ms));

    j=1;
    for i=1:ceil(length(Pos)/2)
        Pos1(j,1)=Pos(2*i-1);
        Pos1(j,2)=Pos(2*i);
        j=j+1;
    end
    Pos=Pos1;
    
    PPPP=size(Pos);
        for i=1:PPPP(1)
            wid1=0;
            wid2=0;
            en=1;
            while en>0
                en=0;
                wid1=wid1+1;
                for k=1:6
                    if (abs(MM(Pos(i,1)-wid1,k))>de(k))
                        en=1;
                    end
                end
            end
            en=1;
            while en>0
                en=0;
                wid2=wid2+1;
                for k=1:6
                    if (abs(MM(Pos(i,2)+wid2,k))>de(k))
                        en=1;
                    end
                end
            end
            if nargin==1
                Pos_w(i,1)=Pos(i,1);
            else
                Pos_w(i,1)=Pos(i,1)-typ*wid1;
            end
            Pos_w(i,2)=Pos(i,2)+wid2;
        end
    DD={};
    j=1;
    for i=1:PPPP(1)
        if Pos_w(i,2)-Pos_w(i,1)>20
            DD{j}=MM(Pos_w(i,1):Pos_w(i,2),:);
            j=j+1;
        end
    end
end
