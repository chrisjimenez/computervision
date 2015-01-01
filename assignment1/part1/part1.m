% CSCI-UA.0480-001 Assignment 1, starter Matlab code
% Adapted from A. Efros
% Edited By Chris Jimenez(3/3/14)
% (http://graphics.cs.cmu.edu/courses/15-463/2010_fall/hw/proj1/)

% name of the input file
imname = 'part1_1.jpg';

% read in the image
fullim = imread(imname);

% convert to double matrix (might want to do this later on to same memory)
fullim = im2double(fullim);

% compute the height of each part (just 1/3 of total)
height = floor(size(fullim,1)/3);
% separate color channels
B = fullim(1:height,:);
G = fullim(height+1:height*2,:);
R = fullim(height*2+1:height*3,:);


% Align the images
% Functions that might be useful to you for aligning the images include: 
% "circshift", "sum", and "imresize" (for multiscale)
fprintf('\nAligning channel G with channel B\n');
aG = align(G,B);
fprintf('\nAligning channel R with channel B\n');
aR = align(R,B);

% create a color image (3D array)
% ... use the "cat" command
resultimage = cat(3,B, aG, aR);

 
% show the resulting image
% ... use the "imshow" command
figure
imshow(resultimage);

% save result image
imwrite(resultimage, 'result_image.png', 'png'); 

