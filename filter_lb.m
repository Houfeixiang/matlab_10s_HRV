function ecg_smooth = filter_lb(ecg,t)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
global fs
w=50/(fs/2);
bw=w/35;
[num,den]=iirnotch(w,bw); %  陷波滤波器
ecg_notch=filter(num,den,ecg);
[e,f]=wavedec(ecg_notch,9,'db6');% 小波实现
g=wrcoef('a',e,f,'db6',9);
ecg_wave=ecg_notch-g; % subtracting 10th level aproximation signal
                      %from original signal                  
ecg_smooth=smooth(ecg_wave); % using average filter to remove glitches平均滤波器去毛刺
                             %to increase the performance of peak detection
% % %  figure(2);                            
% % %  plot(t,ecg_smooth);
% % % %  set(gca,'Fontsize',16);
% % % %  set(gca,'Xlim',[0 650]);
% % % %  %set(gca,'XTick',[0:50:650]);
% % % %  set(gca,'Ylim',[-1.5 1.5]);
% % % %  %set(gca,'YTick',[-1.5:0.3:1.5]);
% % % %  set(h,'LineWidth',0.5);
% % %   grid on;
% % % %  legend(j,'Interpreter', 'none');
% % %   xlabel('Time (s)');
% % %    ylabel('Amplitude (mV)');
% % %    title('Filtered ECG signal');
% set(get(gca,'XLabel'),'Fontsize',16);
% set(get(gca,'YLabel'),'Fontsize',16);
% set(get(gca,'title'),'Fontsize',16);                            
end

