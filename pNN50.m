function out = pNN50(in)
% computes NN50count divided by total number of all NN intervals
%
% IN: vector [1xN] of N R-R intervals (ms)
%
% OUT: pNN50
%
% Jakub Kuzilek, 2012
%
% Ref: Task force of The European Society of Cardiology and North American 
%      Society of Pacing and Electrophysiology: Heart rate variability - 
%      Standards of measurement, phzsiological interpretation, and clinical use
% 
% Status: CHECKED - OK

out = NN50count(in)/length(in);
