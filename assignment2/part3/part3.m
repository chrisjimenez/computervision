%Computer Vision Assignment 2, part 3
%Chris Jimenez
%3/28/14

importfile('sfm_points.mat');

%Set of t which holds all translations for the 10 cameras
set_t = [];
W = [];

%for each view do the following...
for i = 1:10
    sumX = 0;
    sumY = 0;
    
    %for each world point of each view
    %get centroid value
    for j = 1:600
        sumX = sumX + image_points(1,j,i);
        sumY = sumY + image_points(2,j,i);
    end
    
    %print the translation values for the first camera
    if i == 1
        ti = [sumX/600 ; sumY/600]
    else
        ti = [sumX/600 ; sumY/600];
    end
    
    set_t = [set_t ti];
    
    Wj = [];
    
    %for each world point of each view
    %subtract centroid value from x and y
    for j = 1:600
        xj = image_points(1,j,i);
        yj = image_points(2,j,i);
        
        Wj = [Wj [xj - ti(1,1); yj - ti(2,1)]];
    end
    
    W = [W;Wj];
end

%svd of W...
[U, D, Vt] = svd(W);


D_singvals = [ D(1,1); D(2,2); D(3,3) ];

%set of camera locatiosn for the 10 cameras
set_M = [];

%for each view 
for i = 1:10
    
    %print M if i=1, else dont print
    if i == 1
       Mi = U((2*i)-1 : 2*i,1:3 )*D_singvals
    else
       Mi = U((2*i)-1 : 2*i,1:3 )*D_singvals;
    end
    
    set_M = [set_M Mi];
        
end


V = Vt(:, 1:3);

%3D points ofthe 600 points
X = V(:,1);
Y = V(:,2);
Z = V(:,3);

%print the world point coord. for the first 10 world points
for i = 1:10
    Xi = X(i,1)
    Yi = Y(i,1) 
    Zi = Z(i,1) 
end

%plot the points...
plot3(X, Y, Z, '*');





 