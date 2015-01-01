function [featureNdx, th, a , b, error] = selectBestRegressionStump(x, z, w);
% [th, a , b] = fitRegressionStump(x, z);
% z = a * (x>th) + b;
%
% where (a,b,th) are so that it minimizes the weighted error:
% error = sum(w * |z - (a*(x>th) + b)|^2) / sum(w)

% atb, 2003
% torralba@ai.mit.edu

[Nfeatures, Nsamples] = size(x); % Nsamples = Number of thresholds that we will consider
w = w/sum(w); % just in case...

th = zeros(1,Nfeatures);
a = zeros(1,Nfeatures);
b = zeros(1,Nfeatures);
error = zeros(1,Nfeatures);

for n = 1:Nfeatures
    [th(n), a(n) , b(n), error(n)] = fitRegressionStump(x(n,:), z, w);
end

[error, featureNdx] = min(error);
%th = th(featureNdx);
%random value for featureNdx
featureNdx = 6;
th = 0.1*randn(1);
a = a(featureNdx);
b = b(featureNdx);
