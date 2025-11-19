% add paths
addpath('E:\University\EngSci Thesis\Thesis work\functions');

%% Automatically execute runMonthlyAnalysis.m for any year
for year = 2005:2024
    for month = 1:12
        runMonthlyAnalysis(year,month);
    end
end

%% Plot year-long area variation
for year = 2005:2024
    plot_areas_over_one_year(year);
end
%% Automatically execute plot_moving_std.m for any year
for year = 2023:-1:2017
    plot_moving_std(year);
end

%% Visualize polynya at a certain day
plot_extremum_of_month(1,2025)

%% Visualize all extremum events in the winter seasons of all years
for year = 2019:-1:2017
    for month = [1,2,3,4,5,6,11,12]
        plot_extremum_of_month(month, year);
    end
end