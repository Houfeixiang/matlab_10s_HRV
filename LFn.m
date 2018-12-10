function out = LFn(in)
% computes power in normalized low frequency range (0.04 - 0.15 Hz)
%
% IN: vector [1xN] of N R-R intervals (ms)
%
% OUT: LFn
%
% Jakub Kuzilek, 2012
%
% Ref: Task force of The European Society of Cardiology and North American 
%      Society of Pacing and Electrophysiology: Heart rate variability - 
%      Standards of measurement, phzsiological interpretation, and clinical use

out = LF(in)/(totalpower(in)-VLF(in))*100;
