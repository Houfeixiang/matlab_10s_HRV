function out = SDSD(in)
% computes standard deviation of diferences between adjacent NN intervals
%
% IN: vector [1xN] of N R-R intervals (ms)
%
% OUT: SDSD
%
% Jakub Kuzilek, 2012
%
% Ref: Task force of The European Society of Cardiology and North American 
%      Society of Pacing and Electrophysiology: Heart rate variability - 
%      Standards of measurement, phzsiological interpretation, and clinical use
%
% Status: CHECKED - OK

out = std(diff(in));
