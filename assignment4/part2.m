% CSCI-UA.0480-001 Assignment 4 Part 2
% Chris Jimenez

windows_size = 0.25;
input_im = imread('image1.jpg');
test_image = example_mean_shift(input_im ,windows_size);