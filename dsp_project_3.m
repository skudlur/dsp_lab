%% FIR LPF design

clc;
clear;
close all;

fs = 10000;
wp = 0.3*pi;
ws = 0.6*pi; 
tr_width = ws - wp;
M = ceil(6.6*pi/tr_width) + 1;       
wc = (ws + wp)/2;  

alpha = (M - 1)/2;
n = 0:1:(M - 1);
m = n - alpha;
fc = wc/pi;
hd = fc*sinc(fc*m); % Expected Impulse Response

w_ham = hamming(M)';
h = hd .* w_ham; % LPF

t = 0:0.002:1;

% Fourier Transform 

Nfft = length(t);
Nfft = 2^ceil(log2(Nfft)); % radix-2 
f = ((-Nfft/2) : (Nfft/2)-1)/(Nfft*(1/fs));
f1 = f(1,257:end); % Positive frequencies only

% LPF in Frequency domain

LPF = fft(h,Nfft);
LPF = fftshift(LPF);
LPF = abs(LPF); 
LPFDisp = LPF(1,257:end); % LPF spectrum displayed

% Test signals with noise added

in = cos(2*pi*10*t) - sin(4*pi*10*t);

noise = 0.5*rand(length(t));
noise = noise(1,:);

corr = in + noise;

% Input in Frequency domain

in_fft = fft(in,Nfft);
in_fft = fftshift(in_fft);
in_fft = abs(in_fft);
in_disp = in_fft(1,257:end);

% Noise in Frequency domain

noise_fft = fft(noise, Nfft);
noise_fft = fftshift(noise_fft);
noise_fft = abs(noise_fft);
noise_disp = noise_fft(1,257:end);

% Distorted input in Frequency domain

corr_fft = fft(corr, Nfft);
corr_fft = fftshift(corr_fft);
corr_fft = abs(corr_fft);
corr_disp = corr_fft(1,257:end);

CLEAN = corr_fft.*LPF;
CLEANDisp = CLEAN(1,257:end);

clean = conv(corr,h);
clean = clean(1,1:501);

% Plots 

% Design of FIR LPF

figure(1);
sgtitle("Design of FIR LPF");
subplot(2,1,1);
stem(n,h,'r'); 
grid on;
xlabel("Time");
ylabel("Magnitude");
title("Impulse Response");

subplot(2,1,2);
plot(f1, LPFDisp, 'm');
grid on;
xlabel("Frequency");
ylabel("Magnitude");
title("Frequency Response");

% Input Signal

figure(2);
sgtitle("Getting Input Signal");

subplot(3,2,1);
plot(t,in,'r');
grid on;
xlabel("Time");
ylabel("Magnitude");
title("Input Wave");

subplot(3,2,3);
plot(t, noise);
grid on;
xlabel("Time");
ylabel("Magnitude");
title("Additive Noise");

subplot(3,2,5);
plot(t,corr,'m');
grid on;
xlabel("Time");
ylabel("Magnitude");
title("Distorted signal");

subplot(3,2,2);
plot(f1, in_disp,'r');
grid on;
xlabel("Frequency");
ylabel("Magnitude");
title("Input Wave Spectrum");

subplot(3,2,4);
plot(f1, noise_disp);
grid on;
xlabel("Frequency");
ylabel("Magnitude");
title("Distorted Signal Spectrum");

subplot(3,2,6);
plot(f1, corr_disp, 'm');
grid on;
xlabel("Frequency");
ylabel("Magnitude");
title("Distorted Signal Spectrum");

% Output signal

figure(3);
sgtitle("Getting Output Signal");

subplot(3,2,1);
plot(t,corr,'r');
grid on;
xlabel("Time");
ylabel("Magnitude");
title("Input Signal");

subplot(3,2,2);
plot(f1,corr_disp,'r');
grid on;
xlabel("Frequency");
ylabel("Magnitude");
title("Input Signal Spectrum");

subplot(3,2,3);
plot(n,h);
grid on;
xlabel("Time");
ylabel("Magnitude");
title("LPF");

subplot(3,2,4);
plot(f1,LPFDisp);
grid on;
xlabel("Frequency");
ylabel("Magnitude");
title("LPF spectrum");

subplot(3,2,5);
plot(t,clean,'m');
grid on;
xlabel("Time");
ylabel("Magnitude");
title("Output Signal");

subplot(3,2,6);
plot(f1,CLEANDisp,'m');
grid on;
xlabel("Frequency");
ylabel("Magnitude");
title("Output Signal Spectrum");
