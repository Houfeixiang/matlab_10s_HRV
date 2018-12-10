function out = resample(in, fs)
% resamples the NN data to desired sampling frequency
%
% IN: vector [1xN] of N R-R intervals (ms)
%
% OUT: resampled NN
%
% Jakub Kuzilek, 2012
%
% Ref: Task force of The European Society of Cardiology and North American 
%      Society of Pacing and Electrophysiology: Heart rate variability - 
%      Standards of measurement, phzsiological interpretation, and clinical use

out = pchip(cumsum(in)/1000, in, in(1)/1000:1/fs:sum(in)/1000);
