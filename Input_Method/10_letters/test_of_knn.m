load('10_letters_data.mat');
for k=1:5
    for i=1:10
        for j=1:5
            [a(k,i,j),b(k,i,j)]=input_process(V{i}{mod(j+2*k-4-1-3,10)+1},5,k);
        end
    end
end