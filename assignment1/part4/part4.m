% CSCI-UA.0480-001 Assignment 1, part 4
% Image Alignment
% By Chris Jimenez(3/3/14)

%get name of the files of both the images
image1name = 'scene.pgm';
image2name = 'book.pgm';

%call the afftransform function w/ both the images as inputs
afftransform(image1name , image2name);
