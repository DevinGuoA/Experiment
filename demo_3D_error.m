function visualize_interpolation_errors()
    % Generates a 3D curve and fits polynomial interpolants of different degrees.
    % Computes and visualizes interpolation errors.

    clc; clearvars; close all;
    
    % Generate training points
    num_train = 10;  % Number of training points
    t_train = linspace(-1,1,num_train);
    [xt_train, yt_train, zt_train] = get_curve3D(t_train, 0);
    
    % Generate test points (for error evaluation)
    num_test = 50;  % High-resolution test points
    t_test = linspace(-1,1,num_test);
    [xt_test, yt_test, zt_test] = get_curve3D(t_test, 0);
    
    % Degrees to test
    poly_degrees = [2, 4, 6, 8, 10, 12];  
    errors_x = zeros(size(poly_degrees));
    errors_y = zeros(size(poly_degrees));
    errors_z = zeros(size(poly_degrees));
    
    % Iterate over different polynomial degrees
    for i = 1:length(poly_degrees)
        degree = poly_degrees(i);
        
        % Fit polynomials to training data
        px = polyfit(t_train, xt_train, degree);
        py = polyfit(t_train, yt_train, degree);
        pz = polyfit(t_train, zt_train, degree);
        
        % Evaluate on test data
        xt_interp = polyval(px, t_test);
        yt_interp = polyval(py, t_test);
        zt_interp = polyval(pz, t_test);
        
        % Ensure same size before computing error
        if length(xt_interp) ~= length(xt_test)
            error('Size mismatch: Interpolated values and test values must have the same length.');
        end
        
        % Compute mean squared error
        errors_x(i) = mean((xt_interp(:) - xt_test(:)).^2);
        errors_y(i) = mean((yt_interp(:) - yt_test(:)).^2);
        errors_z(i) = mean((zt_interp(:) - zt_test(:)).^2);
    end
    
    % Plot error curves
    figure('Name', 'Interpolation Error vs. Polynomial Degree');
    hold on;
    plot(poly_degrees, errors_x, 'b-o', 'LineWidth', 1.5, 'MarkerSize', 6);
    plot(poly_degrees, errors_y, 'r-s', 'LineWidth', 1.5, 'MarkerSize', 6);
    plot(poly_degrees, errors_z, 'g-d', 'LineWidth', 1.5, 'MarkerSize', 6);
    hold off;
    
    grid on;
    xlabel('Polynomial Degree');
    ylabel('Mean Squared Error');
    title('Interpolation Error for Different Degrees');
    legend({'Error in x(t)', 'Error in y(t)', 'Error in z(t)'}, 'Location', 'best');
    
    fprintf('✅ Interpolation errors computed and plotted successfully!\n');
end

% Run the function
visualize_interpolation_errors();
