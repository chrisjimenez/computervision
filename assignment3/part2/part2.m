% CSCI-UA.0480-001 Assignment 3, part 2 code
% By Chris Jimenez(4/13/14)

%(i) extract dense SIFT;                                DONE
%(ii) form visual word dictionary from training images; DONE

load qu2_data.mat;

%(iii) vector- quantize (VQ) SIFT descriptors to make BoW histograms for each image; 
HISTOGRAMS = example_vq_sift('/Users/Chris/Desktop/Assignment3/part2/data',dictionary);
figure; imagesc(HISTOGRAMS)

%(iv) train classifier on training set histograms and (


%(v) test classifier on test set histograms.
K = 5;
[ACCURACY, PREDICTED_LABELS] = example_classify_nn(TRAIN_IND,TEST_IND,TRAIN_LABEL,TEST_LABEL,HISTOGRAMS,K);

PREDICTED_LABELS

ACCURACY