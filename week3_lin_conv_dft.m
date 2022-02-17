% Linear convolution using DFT/IDFT
clc;
clear;
close all;

x = input("Enter first input sequence: ");
h = input("Enter second input sequence: ");

l1 = length(x);
l2 = length(h);

N = l1 + l2 - 1;
% Built-in fft module
X = calcdft(x, N); % l1 < N and l2 < N
H = calcdft(h, N);
Y = X.*H;
y = ifft(Y);

n1 = 0:l1-1;
n2 = 0:l2-1;
n3 = 0:(length(y)-1);

subplot(3,1,3)
stem(n3,y);
xlabel("Time");
ylabel("Amplitude");
title("Inverse DFT spectrum");

subplot(3,1,1);
stem(n1,x);
xlabel("Time");
ylabel("Amplitude");
title("First input sequence spectrum");

subplot(3,1,2);
stem(n2,h);
xlabel("Time");
ylabel("Amplitude");
title("Second input sequence spectrum");

function [xk] = calcdft(xn,N)
L = length(xn);
if(N<L)
    error("N must be >= L")
end
% If N > L pad zeros to xn
x1 = [xn zeros(1,(N-L))];

% Construct matrix
for k = 0:N-1
    for n = 0:N-1
    p = exp(-i*2*pi*k*n/N);
    T(k+1,n+1) = p;
    end
end
disp("Transformation matrix is: ");
disp(T);
xk = T *x1.'; % ' is transpose | NxN * Nx1
end