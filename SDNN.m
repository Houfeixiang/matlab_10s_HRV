function out = SDNN(in)
% computes standard deviation of normal R-R intervals in whole input data
%
% IN: vector [1xN] of N R-R intervals (ms)
%
% OUT: standard deviation
%
% Jakub Kuzilek, 2012
%
% Ref: Task force of The European Society of Cardiology and North American 
%      Society of Pacing and Electrophysiology: Heart rate variability - 
%      Standards of measurement, phzsiological interpretation, and clinical use
%
% Status: CHECKED - OK

out = std(in);
