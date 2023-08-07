close all;
clear all;
clc;

img = imread('21.jpg');
figure, imshow(img);

load('fixations.mat');
figure, imshow(fixations, []);

gaussian_kernel = fspecial('gaussian', [50 50], 50);
density = imfilter(fixations, gaussian_kernel, 'replicate');

figure, imshow(density,[]);

omask = heatmap_overlay(img, density, 'hsv');
figure, imshow(omask);
colormap(hsv);
colorbar;
