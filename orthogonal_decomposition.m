% orthogonal_decomposition_analysis.m
%
% This script performs orthogonal decomposition on two pre-saved images
% and visualizes the results.

clearvars;
close all;
clc;

% -------------------------------
% Load images from specified file paths
% -------------------------------
img1_path = '/Users/devin/Desktop/CS520 Experiment 4/squirrel_apple.png';
img2_path = '/Users/devin/Desktop/CS520 Experiment 4/squirrel_pear.png';

img1 = imread(img1_path);
img2 = imread(img2_path);

% -------------------------------
% Perform orthogonal decomposition
% -------------------------------
orthogonal_decomposition1(img1, img2);

fprintf('\nOrthogonal decomposition completed.\n');

% ------------------------------------------------------
% Function: orthogonal_decomposition
% Performs orthogonal decomposition of two grayscale images.
% ------------------------------------------------------
function orthogonal_decomposition1(img1, img2)
    % Convert color images to grayscale if needed
    if size(img1, 3) == 3
        img1 = rgb2gray(img1);
    end
    if size(img2, 3) == 3
        img2 = rgb2gray(img2);
    end

    % Convert images to double for calculations
    img1 = double(img1);
    img2 = double(img2);

    % Compute projections
    proj1_on_2 = (dot(img1(:), img2(:)) / dot(img2(:), img2(:))) * img2;
    proj2_on_1 = (dot(img2(:), img1(:)) / dot(img1(:), img1(:))) * img1;

    % Compute orthogonal components
    orth1 = img1 - proj1_on_2;  % Part of img1 dissimilar to img2
    orth2 = img2 - proj2_on_1;  % Part of img2 dissimilar to img1

    % Display results
    figure;
    subplot(2,3,1); imshow(uint8(img1)); title('Original Image 1');
    subplot(2,3,2); imshow(uint8(img2)); title('Original Image 2');
    subplot(2,3,3); imshow(uint8(proj1_on_2)); title('Similar Part (1 projected on 2)');
    subplot(2,3,4); imshow(uint8(orth1 + 128)); title('Dissimilar Part (1 orthogonal to 2)');
    subplot(2,3,5); imshow(uint8(proj2_on_1)); title('Similar Part (2 projected on 1)');
    subplot(2,3,6); imshow(uint8(orth2 + 128)); title('Dissimilar Part (2 orthogonal to 1)');

    % Save results
    save_results(img1, img2, proj1_on_2, orth1, proj2_on_1, orth2);
end

% ------------------------------------------------------
% Function: save_results
% Saves the processed images to files.
% ------------------------------------------------------
function save_results(img1, img2, proj1_on_2, orth1, proj2_on_1, orth2)
    % Save images to files
    imwrite(uint8(img1), 'original_image1.png');
    imwrite(uint8(img2), 'original_image2.png');
    imwrite(uint8(proj1_on_2), 'similar_part_1_on_2.png');
    imwrite(uint8(orth1 + 128), 'dissimilar_part_1_on_2.png');
    imwrite(uint8(proj2_on_1), 'similar_part_2_on_1.png');
    imwrite(uint8(orth2 + 128), 'dissimilar_part_2_on_1.png');

    fprintf('\nResults saved as PNG files in the current directory.\n');
end
