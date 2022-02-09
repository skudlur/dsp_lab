clc;
clear;
close all;

xk = input("Enter the DFT sequence: ");

xn = calcidft(xk);

%% Display and plotting
disp('IDFT - x(n)= ');
disp(xn);
N = length(xn);

% Plotting the parameters
n = 0:N-1;
stem(n,xn);
xlabel("Time");
ylabel("Amplitude");
title("Input sequence spectrum");

%% Function for IDFT

function [xn] = calcidft(xk)
N = length(xk);
for k = 0: N-1
    for n = 0: N-1
        p = exp(i*2*pi*k*n/N);
        IT(k+1, n+1) = p;
    end
end
disp("Transformation matrix is ");
disp(IT);
xn = (IT*(xk.'))./N;
end