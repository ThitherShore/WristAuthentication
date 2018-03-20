run('Data_generate.m');
L=7;
for k=1:L
    for i=1:L
        for j=1:5
            [~,~,ts(5*k-5+1,i*5-5+j)]=judgement(Self{k},Self{i}{j});
            for t=2:5
                ts(5*k-5+t,i*5-5+j)=ts(5*k-5+1,i*5-5+j);
            end
        end
    end
end
imshow(1-ts);