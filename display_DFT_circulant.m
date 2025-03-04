n = 6; % n > 5
c = [1, 2, 3, 4, 5, 6];  
C_n = toeplitz(c, circshift(c, [0, -1]));
display_DFT_circulant1(n, C_n);

function info = display_DFT_circulant1(n, C_n)

if nargin < 2
    error('Not enough input arguments. Usage: display_DFT_circulant(n, C_n)');
end

close all 

fprintf('\n\n   %s began \n', mfilename);

if n <= 5
    error('n must be greater than 5');
end

fprintf('\n\n   Displaying DFT matrix F(%d) and product G(%d) = C(%d) * F(%d)', n, n, n, n);

% Compute DFT matrix F_n and transformed matrix G_n
F_n  = fft(eye(n));
G_n  = C_n * F_n;

%% Display matrices
Bimag = 0; 
Fn_name = sprintf('DFT(%d)', n);
display_complexv_matrix(F_n, Fn_name, Bimag);

Gn_name = sprintf('G(%d) = C(%d) * F(%d)', n, n, n);
display_complexv_matrix(G_n, Gn_name, Bimag);

%% Display element-wise division G_n ./ F_n
Gn_Fn_name = sprintf('G(%d) ./ F(%d)', n, n);
display_complexv_matrix(G_n ./ F_n, Gn_Fn_name, Bimag);

%% Numerical Verification of Relationships
scaling_factors = abs(G_n ./ (F_n + eps));  % Avoid division by zero
row_transformation = C_n * eye(n);  % Identity transformation under C_n

% Compute column-wise mean scaling factors
mean_scaling_factors = mean(scaling_factors, 1);

%% 📌 Print Tabular Results
fprintf('\n\n   Relationship between G_n and F_n:\n');
fprintf('   - Column-wise Mean Scaling Factors:\n');
fprintf('   --------------------------------------\n');
fprintf('   | Col |  1  |  2  |  3  |  4  |  5  |  6  |\n');
fprintf('   --------------------------------------\n');
fprintf('   | Val | %.2f | %.2f | %.2f | %.2f | %.2f | %.2f |\n', mean_scaling_factors);
fprintf('   --------------------------------------\n\n');

fprintf('   - Row Transformation Induced by C_n (First Few Rows):\n');
disp(array2table(row_transformation(1:min(5, n), :), ...
    'VariableNames', arrayfun(@(x) sprintf('Col %d', x), 1:n, 'UniformOutput', false)));

%% 📈 Visualizing Scaling Factors Per Column
figure;
plot(1:n, mean_scaling_factors, '-o', 'LineWidth', 1.5);
title('Mean Scaling Factors Per Column');
xlabel('Column Index');
ylabel('Mean Scaling Factor');
grid on;

%% 🔥 Visualizing Row Transformations
figure;
imagesc(abs(row_transformation));
colorbar;
title('Row Transformations Induced by C_n');
xlabel('Column Index');
ylabel('Row Index');

%% End
fprintf('\n\n   %s ended \n\n', mfilename);

end

%% Supporting Functions 

function info = display_complexv_matrix(X, xname, Bimag)
    tmsg_real = sprintf('%s (Real Part)', xname);
    figure;
    imagesc(real(X)); 
    axis equal off;
    colorbar;
    title(tmsg_real);

    if Bimag 
        tmsg_imag = sprintf('%s (Imaginary Part)', xname);
        figure;
        imagesc(imag(X));
        axis equal off;
        colorbar;   
        title(tmsg_imag);
    end

    info = 1; 
end
