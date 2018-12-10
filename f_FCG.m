function f_spectrum = f_FCG(ecg_smooth1)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
z=ecg_smooth1;ECG=z(:,1);x=ECG(1:1000);%函数里用ecg_smooth1，与主函数中ecg_smmoth一样
y=fft(x,1000);
f_spectrum=abs(y);
f=2*pi/1000:2*pi/1000:2*pi;
% % % figure;
% % % plot(f,f_spectrum);
% % % %axis([0,7,0,100]);
% % % grid on;
% % % xlabel('Frequency (hz)'); ylabel('Amplitude (mv)');
% % % title('FILTERED FCG');
% set(gca,'Fontsize',16);
% set(gca,'Xlim',[0 6.5]);
% set(h,'LineWidth',0.5);
% set(get(gca,'XLabel'),'Fontsize',16);
% set(get(gca,'YLabel'),'Fontsize',16);
% set(get(gca,'title'),'Fontsize',16);
end

