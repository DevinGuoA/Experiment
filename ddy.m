function compute_second_difference_input()
    % Interactive script to compute second-order difference ddy from user input
    
    clc; clearvars; close all;
    
    % Prompt user to enter the sequence y
    y = input('Enter the sequence y as a vector (e.g., [1, 3, 6, 10, 15, 21]): ');
    
    % Validate input
    if length(y) < 3
        error('The input sequence must have at least 3 elements.');
    end
    
    % Compute first-order difference dy
    dy = diff(y);
    
    % Compute second-order difference ddy using diff()
    ddy_standard = diff(dy);
    
    % Direct computation of ddy
    ddy_direct = y(3:end) - 2 * y(2:end-1) + y(1:end-2);
    
    % Display results
    fprintf('\nFirst-order difference (dy):\n');
    disp(dy);
    
    fprintf('Second-order difference (ddy) using diff():\n');
    disp(ddy_standard);
    
    fprintf('Second-order difference (ddy) computed directly:\n');
    disp(ddy_direct);
    
   
end

% Run the function
compute_second_difference_input();
