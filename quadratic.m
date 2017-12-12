% Works to obtain the Quadratic Distance between two Colour images

% ------------------------------------------------------------
% Executes on being called, with inputs:
%   X1 - number of pixels of 1st image
%   X2 - number of pixels of 2nd image
%   map1 - HSV colour map of 1st image
%   map2 - HSV colour map of 2nd image
% ------------------------------------------------------------
function value = quadratic(X1, map1, X2, map2)

% Obtain the histograms of the two images...
[count1, y1] = imhist(X1, map1);
[count2, y2] = imhist(X2, map2);

% Obtain the difference between the pixel counts...
q = count1 - count2;
s = abs(q);

% Obtain the similarity matrix...
A = similarityMatrix(map1, map2);

% Obtain the quadratic distance...
d = s.'*A*s;
d = d^1/2;
d = d / 1e8;

% Return the distance metric.
value = d;

% ------------------------------------------------------------