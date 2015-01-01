% CSCI-UA.0480-001 Assignment 1 part 3
% Scale invariance
% Created By Chris Jimenez(3/3/14)


% name of the input image file
imname = 'einstein.jpg';

%Arbitrary sigma value b/w 2-4
sigma = 3;

%specific row and column were looking at
row = 186;
col = 148;

%STEP 1...
%generate a Laplacian filter of standard deviation sigma
dxx = [1 -2 1];
dyy = dxx';

%create 2D Gaussian filter
h = fspecial('gaussian', sigma*6, sigma);

%computing x and y operator
partderxx = conv2(h, dxx, 'valid');
partderyy = conv2(h, dyy, 'valid');

%Crop x and y operator for addition
partderxx = partderxx(1:end -2, :);
partderyy = partderyy(:,1:end -2);

%visualize lap using mesh()
lapfilter = partderxx +partderyy;
figure
mesh(lapfilter)

%STEP 2...
% read in the image
fullim = imread(imname);
fullim = im2double(fullim);

% half the image 
halfim = imresize(fullim, .50);

%STEP 3...

a = [ ];
b = [ ];
c = [ ];
d = [ ];
sigvals = [];

%iterate through sig 3- 15 in increments of 0.4
for sig = 3:0.4:15
    g = fspecial('gaussian', round(sig*6), sig);
  
    
    partderxx = conv2(g, dxx, 'valid');
    partderyy = conv2(g, dyy, 'valid');

    %Crop x and y operator for addition
    partderxx = partderxx(1:end -2, :);
    partderyy = partderyy(:,1:end -2);

    %calculate lap filter and its normal
    lapfilter = partderxx + partderyy;
    normlapfilter = (sig.^2)*lapfilter;
    
    %Convolve full and half image with lap filter
    fullimconv = conv2(fullim, lapfilter,'same');
    halfimconv = conv2(halfim, lapfilter,'same');
    
    %Convolve full and half image with norm version of lap filter
    fullimconvN = conv2(fullim, normlapfilter,'same');
    halfimconvN = conv2(halfim, normlapfilter,'same');
    
    %Record the four numbers...
    a(end+1) = fullimconv(row, col);
    b(end+1) = halfimconv(row/2, col/2);    
    
    c(end+1) = fullimconvN(row, col);    
    d(end+1) = halfimconvN(row/2, col/2);
    
    sigvals(end+1) = sig;
    
        
end

%Display the plot of Laplacian operator normalized and not normalized
figure
subplot(2,1,1);
plot(sigvals, a, sigvals, b)
title('Laplacian Operator v. Sigma');
xlabel('Sigma');
subplot(2,1,2);
plot(sigvals, c, sigvals, d)
title('Normalized Laplacian Operator v. Sigma');
xlabel('Sigma');

%Determine peak for radius values...
full_normlappeak = findpeaks(c);
half_normlappeak = findpeaks(d);

r1 = max(full_normlappeak);
r2 = max(half_normlappeak);

%Display images with ellipses superimposed at row col location
figure, imshow(fullim), hold on
imellipse(gca, [col row r1 r1]);

figure, imshow(halfim), hold on
imellipse(gca, [col/2 row/2 r2 r2]);









