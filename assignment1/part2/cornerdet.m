function [im, C]= cornerdet( im, threshold, sigma, radius )
%CORNERDET this function looks for corners in an image
%   function looks for corners in an image using the given input variables:
%       im = image where corners are being looked for
%       threshold = "cornerness" theshold
%       sigma = stand. dev. of Gauss. used to smooth 2nd moment matrix
%       radius = radisu of non-maximal suppression;
%   output:
%       im = the original input image
%       C = The corner coordinates [c r]

%1 define filters used to computer image derivatives--good
%this particular one is the Sobel
dx = [ -1 0 1 ; -2 0 2 ; -1 0 1 ];
dy = dx';

%2 compute the actual image derivatives--good
Ix = conv2(im, dx,'same');
Iy = conv2(im, dy,'same');

%3 generate the Guassian smoothing filter
w = fspecial('gaussian', (6*sigma), sigma);

%4 compute the squared derivative valus
Ixsqrd = Ix.^2;
Iysqrd = Iy.^2;
Ixy = Ix .* Iy;

%5 computer smoothed versions of the above...
Ixsqrd = conv2(Ixsqrd,w, 'same');
Iysqrd = conv2(Iysqrd, w, 'same');
Ixy = conv2(Ixy, w, 'same');


%6 Computer cornerness measure M
det = (Ixsqrd.*Iysqrd) - Ixy.^2;
trace = Ixsqrd + Iysqrd;
k = 0.04;

M = det - k*(trace).^2;


%7 Perform non-maximal suppression  
nonmaxsuppress = ordfilt2(M, radius^2, ones(radius));

%Find coordinates of the corner points
%Let C be corner coordinates
crnrs = (M == nonmaxsuppress) & (nonmaxsuppress > threshold);
[r, c] = find(crnrs);
C = [c r];


%Test--using the corner() function for expected output
%C = corner(im);
%imshow(im);
%hold on
%plot(C(:,1), C(:, 2),'r*');

end

