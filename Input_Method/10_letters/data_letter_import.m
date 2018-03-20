function [D,pos,X]=data_letter_import(A,typ)
    XX=importdata(A);
    X=XX.data;
    if nargin==1
        [D,pos]=data_letter_sort(X);
    else
        [D,pos]=data_letter_sort(X,typ);
end