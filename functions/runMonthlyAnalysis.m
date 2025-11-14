% Plot the time series of polynya size over one given month
function runMonthlyAnalysis(year, month)

%%%% User input
latlim = [69.7, 70.8];
lonlim = [-24, -20.95];

% Set up
% load dataset
datasetDir = fullfile('E:', 'University', 'EngSci Thesis', 'Thesis work', 'data', num2str(year));
dataset_string = fullfile(datasetDir, sprintf('seaice_data_m%02u_y%u.mat', month, year));
load(dataset_string);

areas = daily_area(seaice_ts, lat, lon, latlim, lonlim);

% Save daily area data
data_outputDir = fullfile('E:', 'University', 'EngSci Thesis', 'Thesis work', 'results',sprintf('%u', year));
if ~exist(data_outputDir, 'dir')
    mkdir(data_outputDir);
end
dataFilename = fullfile(data_outputDir, sprintf('daily_area_m%02u_y%u.mat', month, year));
save(dataFilename, 'areas', 'digital_date_ts');

% Create a normal figure
% fig = figure('Visible','off');
% plot(day_ts, areas)
% xlim([0 length(day_ts)])
% title(sprintf('Polynya size variation over one month (%u/%u)', year, m))
% xlabel('Day of the month')
% ylabel('Open water area (km^2)')
% 
% 
% % Save figures and close
% figure_outputDir = fullfile('E:', 'University', 'EngSci Thesis', 'Thesis work', 'figures', 'monthly_plot',sprintf('%u', year));
% if ~exist(figure_outputDir, 'dir')
%     mkdir(figure_outputDir);
% end
% figFilename = fullfile(figure_outputDir, sprintf('SeaIce_m%02u_y%u.png', m, year));
% exportgraphics(fig, figFilename, 'Resolution', 300);
% close(fig);
end