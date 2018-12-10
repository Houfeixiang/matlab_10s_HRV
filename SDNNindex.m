function out = SDNNindex(in)
% computes mean of standard deviations of all normal R-R intervals for all 5 min segments in whole input data
%
% IN: vector [1xN] of N R-R intervals (ms)
%
% OUT: SDNN index
%
% Jakub Kuzilek, 2012
%
% Ref: Task force of The European Society of Cardiology and North American 
%      Society of Pacing and Electrophysiology: Heart rate variability - 
%      Standards of measurement, phzsiological interpretation, and clinical use
% 
% Status: CHECKED - PROBABLY OK

indx = find(abs(diff(mod(cumsum(in),300000))) > abs(max(diff(mod(cumsum(in),300000))) - min(diff(mod(cumsum(in),300000))))/2);

if length(indx) == length(in)-1
    out = mean(std(in));
    return;
end

ain = std(in(1:indx(1)));

for m = 1:length(indx)-1
    
    ain(end+1) = std(in((indx(m)+1):indx(m+1)));

end

% ain(end+1) = std(in(min([(indx(end)+1) length(in)]):end)); % add last few
% intervals

out = mean(ain);
