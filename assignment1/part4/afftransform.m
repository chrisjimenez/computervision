% CSCI-UA.0480-001 Assignment 1, part 4
% By Chris Jimenez(3/3/14)
%afftransform.m function

function [ ] = afftransform(imgname1 , imgname2 )
%afftransform This function will compute affine transformation b/w images
%   This function will take two images as inputs and it will compute the
%   affine transformation between them.


[img1, img1desc, img1locs ] = sift(imgname1);
[img2, img2desc, img2locs ] = sift(imgname2);

%get number of descriptors in img1 and img2
k1 = size(img1desc, 1);

k2 = size(img2desc, 1);

%we have set matches where we put all the neighbors of img1 descriptors
%that is below the given threshold 0.9

r1 = [];
c1 = [];
r2 = [];
c2 = [];


%obtain a set of putative matches T
%Computer closest neighbor using Euclidian distance
%for each descriptor in img1, 
for a = 1:k1
    for b = 1:k2
        distance = sqrt(sum((img1desc(a) - img2desc(b)) .^2));
        if distance < 0.9
            r1(end + 1) = img1locs(a, 1);
            c1(end + 1) = img1locs(a, 2);
            r2(end + 1) = img2locs(b, 1);
            c2(end + 1) = img2locs(b, 2);
        end
    end
end

%plot out descriptors
%figure;
%subplot(1,2,1)
%plot(r1', c1', 'r*')
%subplot(1,2,2)
%plot(r2', c2', 'r*')

figure, imshow(img1), hold on
plot(r1', c1', 'r*')

figure, imshow(img2), hold on
plot(r2', c2', 'r*')

T = [r1' c1' r2' c2'];

transimg = ransac(T, 20, img1, img2);

figure
imshow(transimg);



end

