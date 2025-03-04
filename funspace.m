function visualize_function_spaces()
    % Visualize the different nature of x(t), y(t), z(t)
    % Show why they do not belong to the same function space
    
    clc; clearvars; close all;
    
    % Generate t values
    t = linspace(-1,1,100);
    
    % Original functions
    xt = 4 ./ (1 + 25*t.^2); % Runge-like function (rational)
    yt = 1 + 2 * cos(1 + 4*t); % Trigonometric function (cos)
    zt = 2 + sin(2 + 9*t); % Trigonometric function (sin)
    
    % Fit polynomials to these functions
    degree = 6;  % Polynomial degree for approximation
    px = polyfit(t, xt, degree);
    py = polyfit(t, yt, degree);
    pz = polyfit(t, zt, degree);
    
    % Polynomial approximations
    xt_poly = polyval(px, t);
    yt_poly = polyval(py, t);
    zt_poly = polyval(pz, t);
    
    % Plot original functions and polynomial approximations
    figure('Name', 'Function Spaces Comparison');
    
    subplot(3,1,1);
    plot(t, xt, 'b-', 'LineWidth', 1.5);
    hold on;
    plot(t, xt_poly, 'r--', 'LineWidth', 1.5);
    hold off;
    ylabel('x(t)');
    title('Runge Function vs Polynomial Approximation');
    legend('Original x(t)', 'Polynomial Approximation');
    
    subplot(3,1,2);
    plot(t, yt, 'k-', 'LineWidth', 1.5);
    hold on;
    plot(t, yt_poly, 'r--', 'LineWidth', 1.5);
    hold off;
    ylabel('y(t)');
    title('Cosine Function vs Polynomial Approximation');
    legend('Original y(t)', 'Polynomial Approximation');
    
    subplot(3,1,3);
    plot(t, zt, 'm-', 'LineWidth', 1.5);
    hold on;
    plot(t, zt_poly, 'r--', 'LineWidth', 1.5);
    hold off;
    ylabel('z(t)');
    xlabel('t');
    title('Sine Function vs Polynomial Approximation');
    legend('Original z(t)', 'Polynomial Approximation');

end

% Run the function
visualize_function_spaces();
