clc; % clears the command window
clear all; % clears the variables in workspace
close all; % closes all figure windows

f1 = input("Enter the first frequency: ");
f2 = input("Enter the second frequency: ");

fm = max(f1, f2);
nr = 2*fm;

% Oversampling

fs = 2*nr;
ts = 1/fs;
tc = 0:1e-6:(40*ts); % analog time axis

xc = cos(2*pi*f1*tc) + cos(2*pi*f2*tc); % analog signal

td = 0:ts:(40*ts);

xd = cos(2*pi*f1*td) + cos(2*pi*f2*td);

% Reconstruction

N = length(td);
n = 0:N-1;

xr = zeros(size(tc));
sinc_train = zeros(N, length(tc));

for n=0:N-1
    sinc_train(n+1,:) = sinc((tc-n*ts)/ts);
    current_sinc = xd(n+1) * sinc_train(n+1,:);
    xr = xr + current_sinc;
end

%xr = sd *sinc((tc - n'*ts) / ts);

figure(1);
hold on;
grid on;

plot(tc, xc, 'b', 'LineWidth', 2);
stem(td, xd, 'k', 'LineWidth', 2);
plot(tc, xr, 'r', 'LineWidth', 2);

legend('Continuous Time signal', 'Sampled signal', 'Reconstruction signal');

xlabel('Time');
ylabel('Amplitude');
title('Critical sampling');
