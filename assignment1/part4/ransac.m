% CSCI-UA.0480-001 Assignment 1, part 4
% By Chris Jimenez(3/3/14)
% ransac.m function

function [ transformed_image ] = ransac(T, N, image1, image2)
%RANSAC This function will run the RANSAC algorithm on two images using the
%given input paramters...
%   input:
%        T = total number of matches and their coordinates [r1 , c1, r2,
%        c2]
%        N = number of loops
%        image1 = the first image
%        image2 = the second image
%
%   output:
%        transformed_image = image transform between image1 and image2 based on
%        matches

%number of rows in T
Tsize = size(T, 1);

%part T in to img1 and img2 points
img1points = T(:,1:2);
img2points = T(:,3:4);

%keep track of best inlier count and corresponding image points
%bestQ = best transformation
%bestcount= best number of inliers
%bestx and besty, xy coordinates for matches
bestQ = [0, 0, 0, 0, 0, 0]'; 
bestcount = 0;
bestx = [];
besty = [];

for i = 1:N
    
    %P = 3 random mataches
    %rand generates number b/w 0 and 1
    rand1 = round(rand * Tsize);
    rand2 = round(rand * Tsize);
    rand3 = round(rand * Tsize);
   
    %get 3 random matches based on random values above
    randmatch1 = T(rand1, 1:4);
    randmatch2 = T(rand2, 1:4);
    randmatch3 = T(rand3, 1:4);
    
    %matrix A for transformation
    A = [ randmatch1(1) randmatch1(2) 1 0 0 0; 
          0 0 0 randmatch1(1) randmatch1(2) 1;
          randmatch2(1) randmatch2(2) 1 0 0 0; 
          0 0 0 randmatch2(1) randmatch2(2) 1;
          randmatch3(1) randmatch3(2) 1 0 0 0; 
          0 0 0 randmatch3(1) randmatch3(2) 1; ];
    
      %vector b
    b = [randmatch1(3), randmatch1(4), randmatch2(3), randmatch2(4), randmatch3(3), randmatch3(4)];
  
   
    
%vector of unknowns used to tranform points of image 1
    q = b'\A;
    count = 0;
    x = [];
    y = [];

    for j = 1:Tsize
        x_1 = img1points(j, 1);
        y_1 = img1points(j, 2);
        x_2 = img2points(j, 1);
        y_2 = img2points(j, 2);
        P =[ x_1' y_1'];
        transformed_img1points = q' * P;
       
        %distance calculated using euclidian distance formula
        dist = sqrt(((transformed_img1points(1,1) - x_2).^2) + ((transformed_img1points(1,2) - y_2).^2));
        if dist < 10
            count = count+1;
            x(end+1) = transformed_img1points(1,1);
            y(end+1) = transformed_img1points(1,2);

        end
        
    end
   %check if best count of inliers is less than current count or inliers
    if bestcount < count 
        bestcount = count;
        bestQ = q;
        bestx = x;
        besty = y;
    else
        x = [];
        y = [];
    end
    
    count = 0;
end

%best transformation
bestQ;
%best set of inliers
best_setofinliers =[bestx' besty'];

%Transforming image 1 using the best set of transformation parameters, q
H = [ bestQ(1) bestQ(2) bestQ(5) ; bestQ(3) bestQ(4) bestQ(6) ; 0 0 1]
transformed_image = imtransform(image2, maketform('affine', H'));

end

