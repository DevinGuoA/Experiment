% DFT Factorization Visualization with Stride Permutation
% Computes the DFT matrix F_n and applies stride permutations

clearvars;
close all;

% Define n (>1)
n = 4; % You can change this to any n > 1

% Compute DFT matrices
F_n  = fft(eye(n));        % DFT matrix F_n
F_2n = fft(eye(2*n));      % DFT matrix F_2n
F_3n = fft(eye(3*n));      % DFT matrix F_3n

% Compute stride permutations
s2 = 2; % Stride-2 permutation
s3 = 3; % Stride-3 permutation
p2 = stride_permutation(n, s2);  % Compute stride-2 permutation vector
p3 = stride_permutation(n, s3);  % Compute stride-3 permutation vector

% Apply stride permutations to DFT matrices
F_2n_p2 = F_2n(:, p2); % Permuted F_2n with stride-2
F_3n_p3 = F_3n(:, p3); % Permuted F_3n with stride-3

% Display DFT matrices and permuted versions
figure;
tiledlayout(2,3, 'TileSpacing', 'compact', 'Padding', 'compact');

% Plot original F_n
nexttile;
imagesc(real(F_n));
colorbar;
title(sprintf('DFT Matrix F_{%d}', n));
xlabel('Column Index'); ylabel('Row Index');

% Plot F_2n before permutation
nexttile;
imagesc(real(F_2n));
colorbar;
title(sprintf('DFT Matrix F_{%d}', 2*n));
xlabel('Column Index'); ylabel('Row Index');

% Plot F_2n after stride-2 permutation
nexttile;
imagesc(real(F_2n_p2));
colorbar;
title(sprintf('F_{%d} with Stride-2', 2*n));
xlabel('Column Index'); ylabel('Row Index');

% Plot F_3n before permutation
nexttile;
imagesc(real(F_3n));
colorbar;
title(sprintf('DFT Matrix F_{%d}', 3*n));
xlabel('Column Index'); ylabel('Row Index');

% Plot F_3n after stride-3 permutation
nexttile;
imagesc(real(F_3n_p3));
colorbar;
title(sprintf('F_{%d} with Stride-3', 3*n));
xlabel('Column Index'); ylabel('Row Index');

fprintf('\nDFT Factorization with Stride Permutations Completed.\n');

%% Function: Compute Stride Permutation Vector
function p = stride_permutation(n, s)
    % Compute stride permutation vector p_s = [1:s:sn, 2:s:sn, ..., s:s:sn]
    p = [];
    for k = 1:s
        p = [p, k:s:(s*n)]; % Collect elements in stride order
    end
end
