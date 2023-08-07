clear all; % clear previous variables
close all; % close all figures
clc; % clear console
% for loop
%a = [1 2 3 4 5 6];
%count = 0;
%for i = 1:6
    %count = count + a(i);
%end 
%disp(count);

%b = [6 5 4 3 2 1];
%c = 5:10;
%plot(a,b,a,c);

x = 0:pi/100:2*pi;
y1 = sin(x);
y2 = cos(x);
plot(x,y1,x,y2);