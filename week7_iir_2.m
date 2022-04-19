%% IIR filter
% Chebyshev filter

clc;
close all;
clear;

rp = input('Enter the pass band ripple (in dB): ');
rs = input('Enter the stop band ripple (in dB): ');
fs = input('Enter the sampling frequency (in Hz): ');
fp = input('Enter the pass band frequency (in Hz): ');
fst = input('Enter the stop band frequency (in Hz): ');

fn = fs/2; % normalized sampling frequency
fpn = fp/fn; % normalized pass band frequency
fstn = fst/fn; % normalized stop band frequency

[N, wc] = cheb1ord(fpn, fstn, rp, rs);
[b, a] = cheby1(N,rp, wc);
[H, f] = freqz(b, a, 256, fs);

transferfunc = tf(b, a, (1/fs)) 
H_mag = 20*log10(abs(H));
figure;
plot (f, H_mag);
grid on;
xlabel('Frequency in Hz');
ylabel('Magnitude in dB');
title('Magnitude Response');
