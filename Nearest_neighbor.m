%-------------------------------------------------------------------
%Created: 11/9/14 by Elizabeth Brennan, Deanna Jacobson, Frozan Masquodi (All Rights Reserved)
%
%Revision History:  None
%
%Purpose: Find nearest neighbor to point
%
%Variables: 
%   decV - input vector of comparison points
%   m - input vector of point under consideration
%   indx - output value for index of closest point
%   dmin - output value for smallest distance between points
%function [ indx, dmin] = Nearest_neighbor( m, decV )
%-------------------------------------------------------------------

function [ indx, dmin] = Nearest_neighbor( m, decV )
    distance=[]; %initialize distance variable
    %Use pdist2 to go through decV and compare distance to  m:
    distance=pdist2(m, decV); 
    dmin = min(distance); %Get smallest distance from vector
    indx = find(distance == dmin); %get location of min distance   
end

