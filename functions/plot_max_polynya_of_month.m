function plot_max_polynya_of_month(month, year)

% Plot the polynya for days that have a maximum polynya area,
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

[max_value, max_index] = max(areas);

max_message = sprintf('Maximum area in month of m%02u_y%u occurs on day %02u', month, year, day_ts(max_index));

disp(max_message);

% plot max
figure_outputDir = fullfile('E:', 'University', 'EngSci Thesis', 'Thesis work', 'figures', 'extreme_event_plot',sprintf('%u', year));
plot_polynya(max_index, month, year, max_message, figure_outputDir);
