function out = HFn(in)
% computes normalized power in high frequency range (0.15 - 0.4 Hz)
%
% IN: vector [1xN] of N R-R intervals (ms)
%
% OUT: HFn
%
% Jakub Kuzilek, 2012
%
% Ref: Task force of The European Society of Cardiology and North American 
%      Society of Pacing and Electrophysiology: Heart rate variability - 
%      Standards of measurement, phzsiological interpretation, and clinical use

out = HF(in)/(totalpower(in)-VLF(in))*100;
