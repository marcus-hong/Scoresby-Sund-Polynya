function plot_max_areas_across_years(month)
% plot_max_areas_across_years.m finds and plots the maximum areas of polynya of a month over the
% past 20-ish years
% Output:
%   all_max_areas = a 1D array of maximum areas in the, say january, of all past
%   years
%   all_max_area_digital_date = a 1D array of digital dates that correspond to
%   the entries in all_max_areas

all_max_areas = [];
all_max_areas_digital_date = [];
month_string = {'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'};

base_dir = fullfile('E:', 'University', 'EngSci Thesis', 'Thesis work');
input_data_dir = fullfile(base_dir, 'results', 'daily_area');

for yr = 2002:2025
    dataset_string = fullfile(input_data_dir , num2str(yr), sprintf('daily_area_m%02u_y%u.mat', month, yr));
    if isfile(dataset_string)
        load(dataset_string, 'areas', 'digital_date_ts');

        [max_area, max_area_index] = max(areas);
        max_area_date = digital_date_ts(max_area_index);

        all_max_areas = [all_max_areas max_area];
        all_max_areas_digital_date = [all_max_areas_digital_date, max_area_date];
    
    else
        fprintf('Data file not found:\n  %s\n', dataset_string);
    end

end


fig = figure('Visible','off');
plot(year(all_max_areas_digital_date), all_max_areas);
xlabel('Year');
ylabel('Area (km^2)');
title_string = sprintf('Evolution of maximum polynya area in %s from 2022 to 2025', month_string{month});
title(title_string);

% Save data
output_data_dir = fullfile(base_dir, 'results','all_max_areas');
if ~exist(output_data_dir, 'dir')
    mkdir(output_data_dir);
end
output_file_name = fullfile(output_data_dir, sprintf('max_areas_in_m%02u.mat', month));
save(output_file_name, 'all_max_areas', 'all_max_areas_digital_date');

% Save figure
output_fig_dir = fullfile(base_dir, 'figures','evolution_of_month_max');
figFilename = fullfile(output_fig_dir, sprintf('evolution_of_month_max_m%02u.png', month));
exportgraphics(fig, figFilename, 'Resolution', 300);
close(fig);

end