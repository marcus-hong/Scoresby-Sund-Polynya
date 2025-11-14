function [areas] = daily_area(seaice_ts,lat,lon,latlim,lonlim)
%daily_area returns an array of the daily area of open water across one
%month (30 days)

num_days = size(seaice_ts,1);

areas = zeros(1,num_days);
for i = 1:num_days
    seaice = squeeze(seaice_ts(i,:,:));
    areas(i) = calcOpenWater(seaice, lat,lon,latlim,lonlim);
end

end