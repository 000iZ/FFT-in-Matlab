%% Single-sided FFT on Audio Recordings
% Isaac Zhang
% 2023/5/15

clc; close all; clear all;

%% Read audio recording file into MATLAB
% read audio data and sampling frequency of audio recording
filename = "440HzTone.wav";
[y, Fs] = audioread(filename);
Ts = 1/Fs;                          % sampling period
t = 0:1/Fs:(length(y) - 1)/Fs;      % time vector
subplot(1, 3, 1); 
plot(t, y, 'r');                    % waveform in time domain
title("Waveform of Recording " + filename);
xlabel("Time [s]");
ylabel("Relative Intensity");


%% Perform single-sided FFT with padding optimization
% find nearest power of 2 larger than the signal length
% ensures the transform has small prime factors to reduce execution time
p = nextpow2(length(y));
n = 2^p;
Y = fft(y, n);

P2 = abs(Y/n);          % two-sided FFT
P1 = P2(1:n/2+1);       % obtaining frequencies right of the vertical axis
P1(2:end-1) = 2*P1(2:end-1);

%% Plotting FFTs

f1 = Fs * (0:(n/2)) / n;        % frequency vector
subplot(1, 3, 2);
plot(f1, P1);
xlim([0 20000]);                % plot for 0 Hz to 20 kHz
title("Single-sided FFT of " + filename);
xlabel("Frequency [Hz]");
ylabel("Relative Intensity");

subplot(1, 3, 3);
plot(f1, P1);
lower_freq = 0;         % lowerbound frequency to be shown in plot
upper_freq = 1000;      % upperbound frequency
xlim([lower_freq upper_freq]);      % plot with zoomed-in x-axis
title("Truncated FFT of " + filename);
xlabel("Frequency [Hz]");
ylabel("Relative Intensity");

