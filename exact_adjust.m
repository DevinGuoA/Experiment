function [xt, yt, zt] = get_curve3D_exact(t, fig_flag)
% 
%  [xt, yt, zt] = get_curve3D_exact(t, fig_flag);
% 
%   Generates a smooth 3D curve using polynomial functions.
%
%   Inputs:
%   - t: vector of n points within [-1,1] (curve parameter)
%   - fig_flag: boolean (1 to enable visualization, 0 to disable)
%
%   Outputs:
%   - xt: x-coordinate values on the curve (Polynomial)
%   - yt: y-coordinate values on the curve (Polynomial)
%   - zt: z-coordinate values on the curve (Polynomial)

%% Handle Missing Inputs
if nargin < 1  % If t is not provided, generate default values
    t = linspace(-1, 1, 50);  % Default range: 50 points in [-1,1]
end
if nargin < 2  % If fig_flag is not provided, default to no visualization
    fig_flag = 1;
end

t = t(:);  % Ensure column vector

% Validate input range
if any(t < -1) || any(t > 1)
    error('Parameter t must be within the range [-1,1].');
end

% **Replace previous non-polynomial functions with polynomial approximations**
% New Polynomial Representations to Avoid Runge's Phenomenon
xt = 3*t.^5 - 2*t.^3 + t;  % 5th-degree polynomial
yt = -t.^4 + 2*t.^2 - 1;   % 4th-degree polynomial
zt = t.^6 - 3*t.^2 + 2;    % 6th-degree polynomial

%% Visualization
if fig_flag 
    figure('Name', '3D Polynomial Curve');
    plot3(xt, yt, zt, 'bx-', 'LineWidth', 1.5, 'MarkerSize', 6);
    hold on;
    subidx = [1, length(t)];
    plot3(xt(subidx), yt(subidx), zt(subidx), 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8);
    hold off;
    
    % Beautify plot
    grid on; box on;
    xlabel('X'); ylabel('Y'); zlabel('Z');
    title('Generated 3D Polynomial Curve');
    legend({'Curve', 'Endpoints'}, 'Location', 'best');
    view(3); % Ensure a 3D perspective
    
    % Plot coordinate functions
    figure('Name', 'Coordinate Components (Polynomial)');
    
    subplot(3,1,1);
    plot(t, xt, 'b-', 'LineWidth', 1.2);
    hold on;
    plot(t, xt, 'b+', 'MarkerSize', 6);
    hold off;
    ylabel('x(t)');
    title('Polynomial Coordinate Functions Over Parameter t');
    
    subplot(3,1,2);
    plot(t, yt, 'k-', 'LineWidth', 1.2);
    hold on;
    plot(t, yt, 'k+', 'MarkerSize', 6);
    hold off;
    ylabel('y(t)');
    
    subplot(3,1,3);
    plot(t, zt, 'm-', 'LineWidth', 1.2);
    hold on;
    plot(t, zt, 'm+', 'MarkerSize', 6);
    hold off;
    ylabel('z(t)');
    xlabel('t (Curve Parameter)');
end

return 

%% Programmer
%  Xiaobai Sun
