% CSCI-UA.0480-001 Assignment 1, starter align() code
% By Chris Jimenez(3/3/14)

function [bestimage] = align(image1, image2)
%ALIGN This functions aligns two images together.
%   This function will align the two image inputs image1 and image2 and will
%   return the result of the alignment. In addition, the function will also
%   print out the displacement. So image1 will be manipulated(shifted) using
%   circshift() while image2, the base channel, will be left alone. We are
%   assuming also that image1 and image2 are the same dimensions.
    

%First we must resize the images
%image1 = imresize(image1, .75)
%image2 = imresize(image2, .75)


%best value initially set to 0, bestimage initially set to image1
best = intmax();
bestimage = image1;

%x and y displacements currently set to 0;
x = 0;
y = 0;


%iterate through [-15, 15]
for i = -15 : 15
    for j = -15 : 15
        
        %shifted image of image1
        shiftimg = circshift(image1, [i j]);
        
        ssd = sum(sum((shiftimg - image2).^2 ));
        
        %compare the ssd to the current best value...
        if ssd < best
            bestimage = shiftimg;
            best = ssd;
            x = i;
            y = j;
            
        end 
        
    end
end

%print the x and y displacement
fprintf('image1 shifted by %d in the x-direction, and %d in the y-direction\n', x, y);

end
