function [vec]=apply_moments(Image)
%currentimage must be a binary image


% gets property vector for a binary shape in an image
%[H,W] = size(Image);
area = bwarea(Image);


% get scale-normalized central moments
%Center of mass has coordinates u01,u10=0
%u00=area

%vriskoume tis kanonikopoiimenes kentrikes ropes

%covariance or correlation.
u11 = cenmoments(Image,1,1) / (area^2); %to 2 prokiptei apo p+q+2/2
%The two second order central moments measure the spread of points around
%the centre of mass
u20 = cenmoments(Image,2,0) / (area^2);
u02 = cenmoments(Image,0,2) / (area^2);

%Can we measure if the points in the region are spread evenly around the mean?
%Yes, the third order central moments u03, u30, u21, u12 measure that!
%This is commonly referred to as skew and is a measure of the symmetry of the pointspread
u30 = cenmoments(Image,3,0) / (area^2.5); %to 2.5 prokiptei giati einai p+q+2/2, edo p=0,q=3
u03 = cenmoments(Image,0,3) / (area^2.5);
u21 = cenmoments(Image,2,1) / (area^2.5);
u12 = cenmoments(Image,1,2) / (area^2.5);

%It is possible to calculate moments which are invariant under translation,
%changes in scale, and also rotation. Most frequently used are the Hu set
%of invariant moments:
% get invariants

%oi 7 ropes tou Hu
h1 = u20 + u02;
h2 = (u20-u02)^2 + 4*u11^2;
h3 = (u30-3*u12)^2 + (u03-3*u21)^2;
h4 = (u30+u12)^2 + (u03+u21)^2;
h5 = (u30-3*u12)*(u30+u12)*((u30+u12)^2-3*(u03+u21)^2) ...
	+ (3*u21-u03)*(u03+u21)*(3*(u30+u12)^2 - (u03+u21)^2);
h6 = (u20-u02)*((u30+u12)^2-(u03+u21)^2) + 4*u11*(u30+u12)*(u03+u21);
h7 = (3*u21-u03)*(u30+u12)*((u30+u12)^2-3*(u03+u21)^2) ...
	- (u30-3*u12)*(u03+u21)*(3*(u30+u12)^2 - (u03+u21)^2);


   
vec = [h1,h2,h3,h4,h5,h6,h7];    
     


