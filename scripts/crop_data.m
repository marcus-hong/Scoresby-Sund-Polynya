year_range = 2023:-1:2017;
month_range = 1:12;

for year = year_range
    for month = month_range
        baseDir = fullfile('E:', 'University', 'EngSci Thesis', 'Thesis work');
        
        % load data
        input_data_dir = fullfile(baseDir, 'data(raw)', num2str(year));
        
        input_data_string = fullfile(input_data_dir, sprintf('amsr_n3125_Arctic_m%02u_y%u-v5.4.mat', month, year));
        load(input_data_string);
        
        % Crop matrices
        lat = lat(900:1250, 1350:1600);
        lon = lon(900:1250, 1350:1600);
        seaice_ts = seaice_ts(:, 900:1250, 1350:1600);
        
        % Save croped dataset
        output_data_dir = fullfile(baseDir, 'data', num2str(year));
        if ~exist(output_data_dir, 'dir')
            mkdir(output_data_dir);
        end
        
        output_data_string = fullfile(output_data_dir, sprintf('seaice_data_m%02u_y%u.mat', month, year));
        save(output_data_string, 'lat', 'lon', 'seaice_ts', 'digital_date_ts','day_ts', 'month_ts', 'year_ts');
    end
end