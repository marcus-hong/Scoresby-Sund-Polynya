function plot_average_max_vs_min_area

    baseDir = fullfile('E:', 'University', 'EngSci Thesis', 'Thesis work');
    max_data_dir = fullfile(baseDir, 'results','all_max_areas');
    min_data_dir = fullfile(baseDir, 'results','all_min_areas');
    figureDir = fullfile(baseDir, 'figures', 'average_area_per_month');
    
    if ~exist(figureDir, 'dir')
        mkdir(figureDir);
    end
    
    min_mean = zeros(1, 12);
    max_mean = zeros(1, 12);
    month_string = {'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'};
    
    for month = 1:12
        % Load data
        max_data_file_string = fullfile(max_data_dir, sprintf('max_areas_in_m%02u.mat', month));
        min_data_file_string = fullfile(min_data_dir, sprintf('min_areas_in_m%02u.mat', month));
        Max = load(max_data_file_string);
        Min = load(min_data_file_string);
        
        % Take average
        average_max = mean(Max.all_max_areas);
        average_min = mean(Min.all_min_areas);
        
        % Add average_max and average_min to array
        max_mean(month) = average_max;
        min_mean(month) = average_min;

    end        
    
    % Plot
    fig = figure('Visible','off', 'Units','normalized', 'Position',[0.2 0.2 0.5 0.4]);
    
    plot(1:12, max_mean, '-o', 1:12, min_mean, '-o', 'LineWidth', 1.5);
    xlabel('Month');
    ylabel('Area (km^2)');
    grid on;
    title('Average Polynya Area Per Month');
    xticks(1:12)
    xticklabels(month_string);
    legend('Average Max Area', 'Average Min Area', 'Location', 'best');

    % Save figure
    figFilename = fullfile(figureDir, 'average_area_per_month.png');
    exportgraphics(fig, figFilename, 'Resolution', 300);
    close(fig);
end