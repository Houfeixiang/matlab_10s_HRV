function out = VLF(in)
% computes power in very low frequency range (<= 0.04 Hz)
%
% IN: vector [1xN] of N R-R intervals (ms)
%
% OUT: VLF
%
% Jakub Kuzilek, 2012
%
% Ref: Task force of The European Society of Cardiology and North American 
%      Society of Pacing and Electrophysiology: Heart rate variability - 
%      Standards of measurement, phzsiological interpretation, and clinical use

fs = 1000;

[freq, data, N] = psd_estimation(in, fs,'welch');

df = fs/N; % length of PSD window

out = (2*sum(data(freq <= 0.04  & freq > 0)) + data(1))*df; % df - numerical integration I need to add frequency increment
