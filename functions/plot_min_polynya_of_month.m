function plot_min_polynya_of_month(month, year)

% Plot the polynya for the day that has a maximum polynya area,
% and prints a log entry into the local note.txt file

baseDir = fullfile('E:', 'University', 'EngSci Thesis', 'Thesis work');
dataString = fullfile(baseDir, 'results', num2str(year), sprintf('daily_area_m%02u_y%u.mat', month, year));
figureDir = fullfile(baseDir, 'figures', 'extreme_event_plot');
if ~exist(figureDir, 'dir')
    mkdir(figureDir);
end

% load data and determine the date of the month that corresponds to maximum
% area
if isfile(dataString)
    disp(dataString);
    load(dataString, 'areas', 'day_ts', 'month_ts', 'year_ts');
end

[min_value, min_index] = min(areas);

min_message = sprintf('Minimum area in month of m%02u_y%u occurs on day %02u', month, year, day_ts(min_index));

disp(min_message);

% plot min and max
figure_outputDir = fullfile('E:', 'University', 'EngSci Thesis', 'Thesis work', 'figures', 'extreme_event_plot',sprintf('%u', year));
plot_polynya(min_index, month, year, min_message, figure_outputDir);