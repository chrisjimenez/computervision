function [ACCURACY,PREDICTED_LABELS] = example_classify_nn(TRAIN_IND,TEST_IND,TRAIN_LABELS,TEST_LABELS,HISTOGRAMS,K)
  
%%% make output vector
PREDICTED_LABELS = zeros(1,length(TEST_IND));    
    
%%% Get set of *all* train histograms
all_train_hist = HISTOGRAMS(TRAIN_IND,:);

%%%% Main loop over each test example
  
for i=1:length(TEST_IND)
    
  %%% Get histogram for test example i from HISTOGRAMS matrix
  test_hist = HISTOGRAMS(TEST_IND(i),:); 
  
  %%% Compute squared Euclidean distance between test_hist and every
  %%% histogram in all_train_hist
  
  dist_l2 = zeros(length(TRAIN_IND));
  
  for j = 1:length(TRAIN_IND)
        dist_l2(j) =  sqrt(sum( (test_hist(1,:) - all_train_hist(j,:)).^2));
  end
  
  %%% Feel free to try some other distance metric mentioned in the
  %%% slides. Some of them might perform better than Euclidean distance.  
  %% Sort by distance and take closest K points.
  
   [dist_l indices] = sort(dist_l2);
   K_POINTS = indices(1:K)
    
  %% Compute predicted label. 
  %  a number from 1-4
  PREDICTED_LABELS(i) = mode(TRAIN_LABELS(K_POINTS)); 
    
end
  
%%% Compute ACCURACY, i.e. what fraction of the time does
%PREDICITED_LABELS agree with TEST_LABELS
count = 0;
for m = 1:length(PREDICTED_LABELS)
    if(PREDICTED_LABELS(m) == TEST_LABELS(m))
        count = count + 1;
    end
end

ACCURACY = count/length(PREDICTED_LABELS);
