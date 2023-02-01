% Filters in Brainstorm
%
% Raymundo Cassani, 2022

%% Add Brainstorm functions into Path
brainstorm nogui % Start Brainstorm with hidden interface (for scripts)

%% Data 
duration = 10; % s
sfreq = 1000;  % Hz
time = (0 : (duration * sfreq)-1) / sfreq;
x = randn(1, duration * sfreq);

%% Resampling
new_sfreq = 400;
[new_x, new_time] = process_resample('Compute', x, time, new_sfreq);

%% Filters
% [x, FiltSpec, Messages] = process_bandpass('Compute', x, sfreq, HighPass, LowPass, Method=[], isMirror=0, isRelax=0, TranBand=[])
[new_x_filt, FiltSpec] = process_bandpass('Compute', new_x, new_sfreq, 10, 20, 'bst-hfilter-2019');

%% Time series and PSDs
figure()
% original and resampled
h1 = subplot(2,3,[1,2]);
plot(time, x);
hold on
plot(new_time, new_x);
xlabel('time (s)');
legend({'Original','Resampled'})

h1b = subplot(2,3,3);
[X, f] = pwelch(x, [], [], [], sfreq);
plot(f, 10*log10(X));
hold on 
[new_X, new_f] = pwelch(new_x, [], [], [], new_sfreq);
plot(new_f, 10*log10(new_X));
ylabel('PSD (dB/Hz)');
xlabel('frequency (Hz)');
legend({'Original','Resampled'})

% resampled and resample+filtered
h2 = subplot(2,3,[4,5]);
htmp = plot(0,0); % Added to skip 1 plot color
hold on
plot(new_time, new_x);
plot(new_time, new_x_filt);
xlabel('time (s)')
delete(htmp);
legend({'Resampled', 'Filtered'})

h2b = subplot(2,3,6);
plot(0,0); % Added to skip 1 plot color
hold on
plot(new_f, 10*log10(new_X));
[new_X_filt, new_f] = pwelch(new_x_filt, [], [], [], new_sfreq);
plot(new_f, 10*log10(new_X_filt));
ylabel('PSD (dB/Hz)');
xlabel('frequency (Hz)');
legend({'Resampled', 'Filtered'})

% linking X axis
linkaxes([h1, h2], 'xy');
linkaxes([h1b, h2b], 'x');

%% Filter response
figure()
freqz(FiltSpec.b, FiltSpec.a, 1024, sfreq);
