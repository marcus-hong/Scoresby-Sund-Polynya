% add paths
addpath('E:\University\EngSci Thesis\Thesis work\functions');

%% Automatically execute runMonthlyAnalysis.m for any year
for year = 2005:2024
    for month = 1:12
        runMonthlyAnalysis(year,month);
    end
end

%% Plot year-long area variation
for year = 2005
    plot_areas_over_one_year(year);
end

%% Plot evolution of maximum areas of a month, say january, over the past 20-ish years
for month = 1:12
    plot_max_areas_across_years(month);
end

%% Plot evolution of minimum areas of a month, say january, over the past 20-ish years
for month = 1:12
    plot_min_areas_across_years(month);
end

%% Execute plot_moving_std.m for any year
for year = 2024:-1:2002
    disp('Im in the loop');
    plot_moving_std_of_polynya(year);
end

%% Visualize polynya at a certain day
plot_extremum_of_month(1,2025)

%% Visualize all extremum events in the winter seasons of all years
for year = 2019:-1:2017
    for month = [1,2,3,4,5,6,11,12]
        plot_extremum_of_month(month, year);
    end
end
