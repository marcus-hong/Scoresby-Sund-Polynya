function plot_areas_over_one_year(year)

baseDir = fullfile('E:', 'University', 'EngSci Thesis', 'Thesis work');
dataDir = fullfile(baseDir, 'results','daily_area');
figureDir = fullfile(baseDir, 'figures', 'yearly_plot_of_daily_areas');

all_area = [];
all_dates = [];

for m = 1:12
    path_m = fullfile(dataDir, num2str(year), sprintf('daily_area_m%02u_y%u.mat', m, year));
    if isfile(path_m)
        S = load(path_m, 'areas', 'digital_date_ts');
        all_area = [all_area, S.areas];
        all_dates = [all_dates, S.digital_date_ts];
    else
        error_string = sprintf('File "daily_area_m%02u_y%u.mat" is missing', m, year);
        disp(error_string);
    end
end

% Plot all_area against all_dates
fig = figure('Visible','off', 'Units','normalized', 'Position',[0.2 0.2 0.5 0.4]);

plot(all_dates, all_area, 'Color', [0 0 1], 'LineWidth', 1);
title(sprintf('Year long area variation of Scoresby Sund Polynya (%u)', year));
xlabel('Date');
ylabel('Area (km^2)')
is_firstday = day(all_dates)==1;
xticks(all_dates(is_firstday));
xticklabels(datestr(all_dates(is_firstday), 'mmm dd')); % "Jan 01", etc.

% --- Save figure ---
if ~exist(figureDir, 'dir')
    mkdir(figureDir);
end

figFilename = fullfile(figureDir, sprintf('year_long_daily_areas_y%u.png', year));
exportgraphics(fig, figFilename, 'Resolution', 300);
close(fig);

disp(['Saved year long daily area plot for ', num2str(year)]);

end