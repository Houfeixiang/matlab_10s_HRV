function out = HRVindex(in)
% computes HRV triangular index
%
% IN: vector [1xN] of N R-R intervals (ms)
%
% OUT: HRVindex
%
% Jakub Kuzilek, 2012
%
% Ref: Task force of The European Society of Cardiology and North American 
%      Society of Pacing and Electrophysiology: Heart rate variability - 
%      Standards of measurement, phzsiological interpretation, and clinical use
%
% Status: CHECKED - OK

[vals, ~] = hist(in, 0:(1/128*1000):max(in)+10^5/128);

out = length(in)/max(vals);

