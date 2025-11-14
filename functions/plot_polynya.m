function plot_polynya(day, month, year, note, figure_outputDir)
% plot polynya for a given day, and save the plot into the fig_folder_path
% along with a text message (ex: "this is the maximum area of the month")

lat_show = [69 72];
lon_show = [-27 -15];

datasetDir = fullfile('E:', 'University', 'EngSci Thesis', 'Thesis work', 'data', num2str(year));
dataset_string = fullfile(datasetDir, sprintf('amsr_n3125_Arctic_m%02u_y%u-v5.4.mat', month, year));
load(dataset_string);

seaice = double(squeeze(seaice_ts(day,:,:)));

fig = figure('Color','w');

% Set up lambert projection
m_proj('lambert','long',lon_show,'lat',lat_show);

% Overlay sea ice concentration
m_pcolor(lon, lat, seaice);
shading flat;
colormap("turbo");
clim([0 100]);
colorbar;
title_string = sprintf('Lambert Projection of Sea Ice Concentration (%u/%u/%u)', year, month, day);
title(title_string, 'FontSize', 13);

% Add coastlines
% m_coast;    % The most basic coastline resolution is used
m_grid;

% Save figures and close
if ~exist(figure_outputDir, 'dir')
    mkdir(figure_outputDir);
end
figFilename = fullfile(figure_outputDir, sprintf('polynya_y%u_m%02u_d%02u.png', day, month, year));
exportgraphics(fig, figFilename, 'Resolution', 300);
close(fig);

%%% Add note

noteFilename = fullfile(figure_outputDir, 'note.txt');
% Open the file in append mode ('a' creates the file if it does not exist)
fid = fopen(noteFilename, 'a');   % 'a' = append

if fid == -1
    error('Cannot open or create file.');
end

% Write the sentence with a newline
fprintf(fid, '%s\n', note);

% Close the file
fclose(fid);