function [BP]=BP250_3(bp,fs)

lo=(bp-mean(bp))/std(bp);%数据归一化 
u_bp=detrend(lo);
% wp=2*7/fs;                                      
% ws=2*14/fs;
wp=2*5/fs;                                      
ws=2*10/fs; 
Rp=1;                %     1                         
As=30;              %    30
[N,wc]=buttord(wp,ws,Rp,As);        
[B,A]=butter(N,wc);                 
[H,W]=freqz(B,A);                                        
BP=filtfilt(B,A,u_bp);

end
