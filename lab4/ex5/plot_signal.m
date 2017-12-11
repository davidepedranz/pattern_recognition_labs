function plot_signal(signal, fs, my_title)
    L = length(signal);
    fourier = fft(signal);
    P2 = abs(fourier/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    f = fs*(0:(L/2))/L;

    figure;
    
    % plot signal
    subplot(2,1,1);
    plot(1:length(signal), signal);
    title(my_title);
    xlabel('samples')
    ylabel('amplitude')
    
    % plot spectrum
    subplot(2,1,2);
    plot(f, P1);
    title(my_title);
    xlabel('f (Hz)')
    ylabel('|P1(f)|')
end