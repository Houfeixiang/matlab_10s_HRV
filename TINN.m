function out = TINN(in)
% computes baseline width of the minimum square difference triangular
% interpolation of the highes peak of the histogram of normal R-R
%
% IN: vector [1xN] of N R-R intervals (ms)
%
% OUT: TINN
%
% Jakub Kuzilek, 2012
%
% Ref: Task force of The European Society of Cardiology and North American 
%      Society of Pacing and Electrophysiology: Heart rate variability - 
%      Standards of measurement, physiological interpretation, and clinical use
%
% Status: CHECKED - OK

[vals, bins] = hist(in, 0:(1/128*1000):max(in)+1000*1/128*100);

[~,pos] = max(vals);

R = zeros(3,pos*(length(bins)-pos));

counter = 1;
for M = 1:pos
    for N = pos+1:length(bins)
        
        % make triangle
        f = zeros(1,length(bins));
        f(M:pos) = linspace(0,vals(pos),pos-M+1);
        f(pos:N) = linspace(vals(pos),0,N-pos+1);
        
        % compute difference and store
        R(:,counter) = [trapz((vals-f).^2); M; N];
        counter = counter + 1;
    end
end


[~, pos] = min(R(1,:));

out = bins(R(3,pos))-bins(R(2,pos));
