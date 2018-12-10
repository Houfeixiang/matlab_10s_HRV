function out = NN50count(in)
% computes number of pairs of adjacent NN intervals differing by more than
% 50 ms in the entire recording
%
% IN: vector [1xN] of N R-R intervals (ms)
%
% OUT: NN50count
%
% Jakub Kuzilek, 2012
%
% Ref: Task force of The European Society of Cardiology and North American 
%      Society of Pacing and Electrophysiology: Heart rate variability - 
%      Standards of measurement, phzsiological interpretation, and clinical use
%
% Status: CHECKED - OK

out = sum(abs(diff(in))>50);

