% Program to get cross correlation and auto correlation of 2 sequences

clc;
clear;
close all;

x = input('Enter the first sequence: ');
y = input('Enter the second sequence: ');

% fliplr --> to flip a sequence (reverse)

l1 = length(x);
l2 = length(y);

L = l1 + l2 - 1;

%% Formula for convolution
% y(n) = (summation under k) x(k).h(n-k)

%for n = 1 : L
    %r(n) = 0;   
    %for k = 1:l1
        %if ((n-k)>=0 && (n-k)<=l2)
            %r(n) = r(n)+r(k).y(n-k+1);
        %end
    %end
%end

%% Hermitian property

r = xcorr(x,y); % xcorr is an in-built function for correlation
r1 = xcorr(y,x);
if (r == fliplr(r1))
    disp('Hermitian property is satisfied.');
else
    disp('Hermitian property is not satisfied.');
end

%% Convolution of the two sequences using in-built function

lc = conv(x,y);
R = int8(r); % To convert the data type
if (R == lc)
    disp('Second sequence is symmetric.');
else
    disp('Second seqeunce is not symmetric.');
end

%% Orthogonality checking

if r(((L-1)/2)+1) == 0
    disp('Sequences are orthogonal.');
else
    disp('Sequences are not orthogonal.')
end
