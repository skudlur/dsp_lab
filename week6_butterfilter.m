%% Program for Butterworth filter

clc;
close all;
clear;

% Taking Inputs

fp = input('Enter the pass band edge frequency: ');
fs = input('Enter the stop band edge frequency: ');
ap = input('Enter the pass band attenuation: ');
as = input('Enter the stop band attenuation: ');

% Omega values

%omp = 2*pi*fp;
%oms = 2*pi*fs;

omp = fp;
oms = fs;

% Equations 

n1 = (10 ^ (-0.1 * ap)) - 1
n2 = (10 ^ (-0.1 * as)) - 1
nm = log10(n1/n2);
d = 2 * log10(omp/oms);
N = ceil(nm/d);
disp(N);
temp = 1/2*N;

omc = omp/(n1^temp);

[b, a] = butter(N, omc, 's'); % Butterworth LPF 
%[b, a] = butter(N, omc, 'high', 's'); % Butterworth HPF 
%[b, a] = butter(N, omc, 'bandpass' ,'s'); % Butterworth BPF 
%[b, a] = butter(N, omc, 'stop' ,'s'); % Butterworth BSF 

fr = 0 : 50 : 2*fs;

[H, w] = freqs(b, a, 2*pi*fr);

magH = 20*log10(abs(H));
f = w/(2*pi);

% Plotting

sgtitle('Suhas KV | PES2UG20EC093');
title('Butterworth Filter');
xlabel('Frequency');
ylabel('Gain');
plot(f,magH);