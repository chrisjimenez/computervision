%Computer Vision Assignment 2, part 2
%Chris Jimenez
%3/28/14

%Get the world points from input file(3D)
world_points = dlmread('world.txt');

%Get the image points from input file(2D)
image_points = dlmread('image.txt');

%Both world and image points must be converted
%to homogenous points...

ones_row = ones(1, 10);

world_points = [world_points; ones_row]

image_points = [image_points; ones_row]

% Create 20x12 matrix where each correspondence(10) 
% contributes 2 rows
zero_row = [0, 0, 0, 0];

A = [ ];

for i = 1:10
    
    X_i = world_points(:, i);
    
    x_i = image_points(1,i);
    y_i = image_points(2,i);
    w_i = image_points(3,i);
    
    A = [A; zero_row, -w_i*X_i', y_i*X_i'];
    A = [A; w_i*X_i', zero_row, -x_i*X_i'];

end


% get svd of A, use for computing P later
A_svd = svd(A);

% Compute P by reshaping A_svd to a 3 by 4 matrix
P = reshape(A_svd,3, 4)

% Verify by re-projecting the world_points and check
% if they are close to their corresponding image_points
image_points_ver = [ ];
temp = [];

%Check if calculated image point match the input image points...
for i = 1:10
    X_i = world_points(:, i);
    temp = [temp P*X_i];
    
    x_i = temp(1,i)/ temp(3,i);
    y_i = temp(2,i)/ temp(3,i);
    
    image_points_ver = [image_points_ver [x_i;y_i]];
    
end

%Display calculate image points...
image_points_ver


%Calculate C...
C = null(P);

C = [ C(1,1)/C(4,1) ; C(2,1)/C(4,1) ; C(3,1)/C(4,1) ]





