function [areas] = daily_area(seaice_ts,lat,lon,latlim,lonlim)
%daily_area returns an array of the daily area of open water across one
%month (30 days)

areas = zeros(1,30);
for i = 1:30
    seaice = squeeze(seaice_ts(i,:,:));
    areas(i) = calcOpenWater(seaice, lat,lon,latlim,lonlim);
end

end