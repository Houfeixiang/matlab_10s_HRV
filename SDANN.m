function out = SDANN(in)
% computes standard deviation of the averages of R-R interval for all 5 min segments in whole input data
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
    out = std(mean(in));
    return;
end

ain = mean(in(1:indx(1)));

for m = 1:length(indx)-1
    
    ain(end+1) = mean(in((indx(m)+1):indx(m+1)));

end

% ain(end+1) = mean(in(min([(indx(end)+1) length(in)]):end));

out = std(ain);
