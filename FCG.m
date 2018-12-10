function  spectrum=FCG(ecg)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
d=ecg;ECG=d(:,1);x=ECG(1:1000);
y=fft(x,1000);
spectrum=abs(y);
f=2*pi/1000:2*pi/1000:2*pi;
% % % figure;
% % % plot(f,spectrum);
% % % grid on;
% % % %axis([0,100,0,7]);
% % % xlabel('Frequency (hz)'); ylabel('Amplitude (mv) ');
% % % title('FCG');
% set(gca,'Fontsize',16);
% set(gca,'Xlim',[0 6.5]);
% set(h,'LineWidth',0.5);
% set(get(gca,'XLabel'),'Fontsize',16);
% set(get(gca,'YLabel'),'Fontsize',16);
% set(get(gca,'title'),'Fontsize',16);
end

