function [aow] = calcOpenWater(seaice,lat,lon,latlim,lonlim)
%calcOpenWater Calculate area of open water for a given polynya region
%
%   aow = calcOpenWater(latlim,lonlim)
%
% Inputs:
%   seaice      - seaice concentration 2D matrix
%   lon         - lon 2D matrix
%   lat         - lat 2D matrix
%   latlim      - vector of mininmum and maximum latitude of the open water (i.e., [lat_min, lat_max]) 
%   lonlim      - vector of mininmum and maximum longitude of the open water (i.e., [lon_min, lon_max]) 
%
% Output:
%   aow - total area of open water (same units as 3.125 scaling factor)

    % Unpack latlim,lonlim vectors
    lat_min = latlim(1); 
    lat_max = latlim(2); 
    lon_min = lonlim(1);
    lon_max = lonlim(2);

    % Get linear array of indices of the matrix cells that represents a
    % point in the region of interest (roi)
    roi = find(lat>=lat_min & lat<=lat_max & lon >= lon_min & lon <= lon_max);

    aow = 0;  % initialize total area
    
    for i = roi(:)'  % loop through each point in ROI
        if ~isnan(seaice(i))  % skip land points (NaN)
            aow_i = 3.125 * (100 - seaice(i)) / 100;
            aow = aow + aow_i;
        end
    end
    
end