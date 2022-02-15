clc;
clear;
close all;

x = input('x(n)=');
h = input('h(n)=');

l1 = length(x);
l2 = length(h);

N = max(l1,l2);
x = [x zeros(1, (N-l1))];
h = [h zeros(1, (N-l2))];

% using in-built function
%z = cconv(x,h,N);
%disp(z);

% using the formula 
for n = 1:1:N
    y(n) = 0;
    for k = 1:1:N
        y(n) = y(n) + x(k) * h(mod((n-k), N)+1);
    end
end

n = 0:(N-1);
subplot(3,1,1);
stem(n,x,'k'); grid on;
xlim([-1 4]);
xlabel('Time');
ylabel('Amplitude');
title('Input sequence');

subplot(3,1,2);
stem(n,h,'k'); grid on;
xlim([-1 4]);
xlabel('Time');
ylabel('Amplitude');
title('Impulse Response');

subplot(3,1,3);
stem(n,y,'k'); grid on;
xlim([-1 4]);
xlabel('Time');
ylabel('Amplitude');
title('Circular Convolution');
sgtitle('Suhas KV | PES2UG20EC093')
disp(y);
disp(n);
