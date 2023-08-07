close all;
clear all;
clc;

% create random data
n = 15;
data = rand(1,n);

% set colors
colors = (jet(n)+1)/2;

% add labels
labels = {};
for i = 1:n
    labels{i} = sprintf('%2.1f%%', 100*data(i)/sum(data));
end

% partition the data to blocks
rectangles = treemap(data);

% plot the tree map
plotRectangles(rectangles, labels, colors);