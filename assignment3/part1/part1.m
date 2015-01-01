% CSCI-UA.0480-001 Assignment 3, part 1 code
% By Chris Jimenez(4/13/14)

importfile('ORL_32x32.mat');
importfile('train_test_orl.mat');


%Set K
K = 20;

%//////////////////////////////////////////////////////////////////////
% 1. Split fea and gnd into training and test sets using the indices in
% trainIdx and testIdx.
fea_train_set = fea(trainIdx,:);
gnd_train_set = gnd(trainIdx,:); 
fea_test_set = fea(testIdx,:);
gnd_test_set = gnd(testIdx,:); 


% Scale the images so that the intensities range from 0 to 1.
fea_train_set = mat2gray(fea_train_set);
fea_test_set = mat2gray(fea_test_set);

%/////////////////////////////////////////////////////////////////////
% 2. Center the training data, so that the per-pixel mean of across all 
% images is zero. 3. Form C, the 1024 by 1024 covariance matrix.

train_rot = rot90(fea_train_set);
per_pixel_mean = mean(train_rot,2);
centered_data = train_rot - repmat(per_pixel_mean, 1, size(train_rot,2));

C = centered_data * centered_data';

%/////////////////////////////////////////////////////////////////////
% 4. Compute the first K principal components v of C using the eigs
% function
[v,d] = eigs(C,K);

%////////////////////////////////////////////////////////////////////
% 5. Plot out these principal components.
eigenfaces = rot90(v,2);
figure; montage(reshape(eigenfaces,[32 32 1 K]));

%///////////////////////////////////////////////////////////////////
% 6. Project the centered training data into the PCA space using the
% principal components, yielding descriptors p.
p = centered_data' * eigenfaces;

%///////////////////////////////////////////////////////////////////
% 7. Form Reconstruction of the face by projecting back into 
% the image space
face = p * v';
face = rot90(face);
face = face + repmat(per_pixel_mean, 1, size(face,2));

%///////////////////////////////////////////////////////////////////
% 8. Center and project test data into PCA space
fea_test_rot = rot90(fea_test_set);
per_pixel_mean = mean(fea_test_rot,2);
centered_test = fea_test_rot - repmat(per_pixel_mean, 1, size(fea_test_rot,2));
q = centered_test' * eigenfaces;

% /////////////////////////////////////////////////////////////////////////
% 9. Perform nearest-neighbor search for each of the descriptors in q
% to find closest Euclidean descriptor in p
nns_set = [];
[idx, dist] = knnsearch(p,q,'dist','euclidean','k',K);
for j=1:size(idx,1)
    nns_set = [nns_set;gnd_train_set(idx(j,1),:)];
end

%//////////////////////////////////////////////////////////////////
% 10. Measure fraction correctly classified
matches = 0;
for j = 1: size(nns_set)
    matches = matches + ( nns_set(j) == gnd_test_set(j) );
end


total = size(nns_set,1);
percent = round((matches / total) * 100);
title(sprintf('Matched %i of %i (%i%%)',matches,total, percent));


