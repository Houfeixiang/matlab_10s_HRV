function out = RMSSD(in)
% computes root of mean of sum of all square differences between adjacent
% normal R-R intervals
%
% IN: vector [1xN] of N R-R intervals (ms)
%
% OUT: RMSSD
%
% Jakub Kuzilek, 2012
%
% Ref: Task force of The European Society of Cardiology and North American 
%      Society of Pacing and Electrophysiology: Heart rate variability - 
%      Standards of measurement, phzsiological interpretation, and clinical use
%
% Status: CHECKED - OK

out = sqrt(mean(diff(in).^2));
