clc;
clear;
close all;

xn = input("Enter the input sequence: ");
N = input("Enter the number of DFT points: ");

xk = calcdft(xn, N);

%% Display and plotting
disp('DFT - X(k)= ');
disp(xk);

% Magnitude of DFT
magxk = abs(xk);

% Phase of DFT
phasexk = angle(xk);

% Plotting the parameters
k = 0:N-1;
subplot(2,1,1);
stem(k,magxk);
xlabel("");
ylabel("");
title("Magnitude spectrum");

subplot(2,1,2);
stem(k,phasexk);
xlabel("");
ylabel("");
title("Phase spectrum");

%% DFT Function
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
