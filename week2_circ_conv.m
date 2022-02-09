clc;
clear all;
close all;

x = input('x(n)=');
h = input('h(n)=');

l1 = length(x);
l2 = length(h);

N = max(l1,l2);
x = [x zeros(1, (N-l1))];
h = [h zeros(1, (N-l2))];

% using in-built function
z = cconv(x,h,N);
disp(z);

% using the formula 
for n = 1:1:N
    y(n) = 0;
    for k = 1:1:N
        y(n) = y(n) + x(k) .* h(mod(n-k), N);
    end
end

subplot(3,1,1);
stem(n,x); grid on;
xlabel('Time');
ylabel('Amplitude');
title('Input sequence');

subplot(3,1,2);
stem(n,h); grid on;
xlabel('Time');
ylabel('Amplitude');
title('Impulse Response');

subplot(3,1,3);
stem(n,z); grid on;
xlabel('Time');
ylabel('Amplitude');
title('Output');
disp(z);
disp(n);