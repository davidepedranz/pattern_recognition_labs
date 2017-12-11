clf; close all;
clear;

% extract signal from file
[signal, fs] = audioread('data/corrupted_voice.wav');
plot_signal(signal, fs, 'original signal');

% filter noise at 6000 Hz
[b_high, a_high] = butter(2, [5900, 6100] / (fs / 2), 'stop');
signal_no_high_noise = filter(b_high, a_high, signal);
plot_signal(signal_no_high_noise, fs, 'filter at 6000 Hz');
audiowrite('output/signal_no_high_noise.wav', signal_no_high_noise, fs);

% filter noise at 100 Hz
[b_low, a_low] = butter(2, [99, 101] / (fs / 2), 'stop');
signal_no_low_noise = filter(b_low, a_low, signal);
plot_signal(signal_no_low_noise, fs, 'filter at 100 Hz');
audiowrite('output/signal_no_low_noise.wav', signal_no_low_noise, fs);

% filter both
signal_no_noise = filter(b_low, a_low, filter(b_high, a_high, signal));
plot_signal(signal_no_noise, fs, 'filter both at 100 Hz and at 6000 Hz');
audiowrite('output/signal_no_noise.wav', signal_no_noise, fs);
