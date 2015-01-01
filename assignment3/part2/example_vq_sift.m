function HISTOGRAMS = example_vq_sift(SIFT_FILE_PATH,DICTIONARY)
  
  %%% get list of all precomputed SIFT files
  file_names = dir([SIFT_FILE_PATH,'/image*sift.mat']);
  
  %%% get size of visual dictionary
  nBins = size(DICTIONARY,1);
  nCols = 128;
    
  %%% Setup output
  HISTOGRAMS = zeros(length(file_names),nBins);
  
  %% Main loop over SIFT files.
  %Loops 800 times
  for i = 1:length(file_names)
    
    %%% Load in each SIFT file for each image
    load([SIFT_FILE_PATH,'/',file_names(i).name]);
    
    %%% Get all SIFT descriptors for the image
    sifts = features.data;
    
    %%% How many in this image?
    nSift = size(sifts,1);
    
    %% Now loop over all SIFT descriptors in image 
    %Loops nSift times
    for j = 1:nSift       
       
       best_bin = 1;
       best_distance = 1000;
    
      %% Find the closest DICTIONARY element. Use squared Euclidean distance
      %Loops 200 times
      for k = 1:nBins
          distance = sqrt(sum( (DICTIONARY(k,:) - sifts(j,:)).^2));
          
          if distance < best_distance
              best_distance = distance;
              best_bin = k;
          end
       
      end
      
      %%% Increment HISTOGRAMS count
      HISTOGRAMS(i, best_bin) = HISTOGRAMS(i, best_bin) + 1;
    end  
  end 
end
  
