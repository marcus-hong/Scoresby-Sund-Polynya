% Compute & plot daily polynya areas and its 30-day centered moving standard deviation over one year.
% Handles varying month lengths and missing days across months.
% Uses 'areas', 'digital_date_ts' from each monthly .mat file.
% Adds Dec (previous year) and Jan (next year) data for window continuity.
function plot_moving_std_of_polynya(targetYear)

% --- User settings ---
windowSize = 30;   % centered window (in days)

baseDir = fullfile('E:', 'University', 'EngSci Thesis', 'Thesis work');
dataDir = fullfile(baseDir, 'results','daily_area');
figureDir = fullfile(baseDir, 'figures', 'moving_std');

% --- Load Dec (prev), 12 months (current), Jan (next) ---
all_area = [];
all_dates = [];

% Previous December
if targetYear > 0
    dec_path = fullfile(dataDir, num2str(targetYear-1), sprintf('daily_area_m12_y%u.mat', targetYear-1));
    if isfile(dec_path)
        S = load(dec_path, 'areas', 'digital_date_ts');
        all_area = [S.areas, all_area];
        all_dates = [S.digital_date_ts, all_dates];
    else
        disp(sprintf('%s file not loaded.\n', dec_path));
    end
end

% Current targetYear months (whatever months available)
for m = 1:12
    path_m = fullfile(dataDir, num2str(targetYear), sprintf('daily_area_m%02u_y%u.mat', m, targetYear));
    if isfile(path_m)
        S = load(path_m, 'areas', 'digital_date_ts');
        all_area = [all_area, S.areas];
        all_dates = [all_dates, S.digital_date_ts];
    else
        disp(sprintf('%s file not loaded.\n', path_m));
    end
end

% Following January
jan_path = fullfile(dataDir, num2str(targetYear+1), sprintf('daily_area_m01_y%u.mat', targetYear+1));
if isfile(jan_path)
    S = load(jan_path, 'areas', 'digital_date_ts');
    all_area = [all_area, S.areas];
    all_dates = [all_dates, S.digital_date_ts];
else
    disp(sprintf('%s file not loaded.\n', jan_path));
end

% --- Compute centered moving std ---
mov_std = movstd(all_area, windowSize, 'omitnan');

% --- Extract main targetYear (discard prev/next targetYear dates used for continuity) ---
inYear = year(all_dates) == targetYear;
mov_std = mov_std(inYear);
all_area = all_area(inYear);
all_dates = all_dates(inYear);

% --- Plotting ---
fig = figure('Visible','off', 'Units','normalized', 'Position',[0.2 0.2 0.5 0.4]);

yyaxis left
plot(all_dates, all_area, 'Color', [0.6 0.6 0.6], 'LineWidth', 1);
ylabel('Open water area (km^2)');

yyaxis right
plot(all_dates, mov_std, 'b', 'LineWidth', 1.5);
ylabel(sprintf('%d-day centered std (km^2)', windowSize));

title(sprintf('Polynya Area and Moving Standard Deviation Over One Year (%u)', targetYear));
xlabel('Date');
grid on;

% Format x-axis: show first day of each month
is_firstday = day(all_dates)==1;
xticks(all_dates(is_firstday));
xticklabels(datestr(all_dates(is_firstday), 'mmm dd')); % "Jan 01", etc.
xlim([all_dates(1), all_dates(end)]);
legend({'Daily area','30-day std'}, 'Location', 'best');

% --- Save figure ---
if ~exist(figureDir, 'dir')
    mkdir(figureDir);
end

figFilename = fullfile(figureDir, sprintf('MovingStd_y%u_centered.png', targetYear));
exportgraphics(fig, figFilename, 'Resolution', 300);
close(fig);

disp(['Saved centered moving std plot for ', num2str(targetYear)]);
