function extract_fig_data(fig_filename, output_filename)
    % Load the .fig file
    fig = openfig(fig_filename, 'invisible');
    ax = findall(fig, 'Type', 'axes'); % Find all axes in the figure
    data = struct(); % Initialize a structure to store data
    
    for i = 1:length(ax)
        % Find all line objects in the current axis
        lines = findall(ax(i), 'Type', 'line');
        
        for j = 1:length(lines)
            % Extract X and Y data from each line
            xData = get(lines(j), 'XData');
            yData = get(lines(j), 'YData');
            
            % Store the data with unique field names
            fieldName = sprintf('Axis%d_Line%d', i, j);
            data.(fieldName).X = xData;
            data.(fieldName).Y = yData;
        end
    end
    
    % Save the extracted data to a .mat file
    % (ex:extract_fig_data('focused_140kg_KF1m.fig', 'knee_A.mat');)
    save(output_filename, '-struct', 'data');
    
    % Close the figure
    close(fig);
    
    fprintf('Data extracted and saved to %s', output_filename);
end
