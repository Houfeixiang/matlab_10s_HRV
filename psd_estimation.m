function [freq, out, N] = psd_estimation(in, fs, method)

out = resample(in, fs); % resampling

p = polyfit(1:length(out),out,1); % detrending

out = out - p(1)*(1:length(out))-p(2);

if nargin == 2
    method = 'periodogram';
end

switch method
    case 'periodogram'
        h = spectrum.periodogram;
        hpsd = psd(h, out, 'Fs', fs, 'NFFT', length(out));
        N = length(out); % length of window
    case 'welch'
        h = spectrum.welch;
        hpsd = psd(h, out, 'Fs', fs, 'NFFT', length(out));
        N = length(out); % length of window
end

freq = hpsd.Frequencies;
out = hpsd.Data;


