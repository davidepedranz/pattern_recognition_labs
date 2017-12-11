clf; close all;
clear;

% load the noisy image
original = double(mat2gray(imread('data/dogGrayRipples.png')));

% compute the fourier tranform
spec_original = fft2(original);
spec_img = fftshift(spec_original);

% find the noise
radius = 11;
spec_filtered_square = remove_second_max(remove_second_max(spec_img, radius, true), radius, true);
spec_filtered_circle = remove_second_max(remove_second_max(spec_img, radius, false), radius, false);

% clean the image
cleaned_square = real(ifft2(ifftshift(spec_filtered_square)));
cleaned_circle = real(ifft2(ifftshift(spec_filtered_circle)));

% show the Fourier tranforms and masks
figure;
montage(log(abs([spec_img, spec_filtered_square, spec_filtered_circle])), 'DisplayRange', []);
saveas(gcf, 'output/fourier', 'png');

% show the image before and after
figure;
montage([original, cleaned_square, cleaned_circle]);
saveas(gcf, 'output/process', 'png');