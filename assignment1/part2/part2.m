%   CSCI-UA.0480-001 Assignment 1 part 2
%   Harris Corner Detector
%   Created By Chris Jimenez(3/3/14)


%name of the input file
imname = 'einstein.jpg';

%read in the image
%image is already in grayscale
fullim = imread(imname);

%convert image to double
fullim = im2double(fullim);

%1. Call cornerdet function on full image
[fullim, A] = cornerdet(fullim,5e-4,3,3);

%Display image with corners superimposed...
figure, imshow(fullim), hold on
plot(A(:,1), A(:, 2),'r*');

%2. Call cornerdet function on rotated image(45 degrees) & display
rotatedimage = imrotate(fullim, 45);
[rotatedimage, B] = cornerdet(rotatedimage,5e-4,3,3);

figure, imshow(rotatedimage), hold on
plot(B(:,1), B(:, 2),'r*');

%3. Call cornerdet function on intensified image(1.5) & display
intensifiedimage = fullim * 1.5;
[intensifiedimage, C] = cornerdet(intensifiedimage,5e-4,3,3);

figure, imshow(intensifiedimage), hold on
plot(C(:,1), C(:, 2),'r*');

%4. Call cornerdet function on halfed image & display
halfimage = imresize(fullim, .5);
[halfimage, D] = cornerdet(halfimage, 5e-4, 3, 3);

figure, imshow(halfimage), hold on
plot(D(:,1), D(:, 2),'r*');









