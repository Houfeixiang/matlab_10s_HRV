clc;
clear;
close all;
global fs;
fs=1000;
%% HRV只有时域段处理。
load('/Users/houfeixiang/Downloads/军科院动物实验/动物实验数据/旧数据/20180411/清洗后分段数据/4.11升压.mat')
ecg=data(:,2);
ecg=data(10001:20000,2);
% plot(ecg);
A=ecg;
N=length(A);
t=(0:N-1)/fs; %时间段（总样本数/ Fs），时间从零开始。
figure(1);
plot(t,A,'r');
grid on;
title('ECG SIGNAL')             
xlabel('Time (s)')
ylabel('Amplitude (mv)')
%% 滤波和频谱
ecg_smooth=filter_lb(A,t);    %滤波,小波变换。
%%
figure;
plot(A,'r')
hold on
plot(ecg_smooth,'k')
title('原始和滤波后的ECG图像')
%%
spectrum=FCG(A);  %原始心电频谱图
f_spectrum=f_FCG(ecg_smooth);  %滤波后心电频谱
[qrs_amp_raw,qrs_i_raw,delay]=pan_tompkin(A,fs,0);
RT=[];
N2=length(qrs_i_raw);
for i1=1:N2
     RT(i1)=(qrs_i_raw(i1)-1)/fs;
end
m=RT';               % converting rows in column;转换列中的行;
k=length(m);
rr2=[m(2:k)]*1000;       %s从第二点到最后一点的第二个数组;
rr1=[m(1:k-1)]*1000;    %从第一到第二个最后一个点的第一个数组
                                   % rr2＆rr1现在是等长的;
rr7 = rr2-rr1; 
figure;
subplot(211);plot(rr7);       %axis([0 600 200 1400])
title('原始rr间期波形');
rr3 = clear_RR_abp(rr7); 
subplot(212);plot(rr3);       %axis([0 600 200 1400])
title('异常点剔除后rr间期波形');
rr8=(rr3');
hr=60000./rr8;         % computate heart rate variation ;计算心率
%%
figure;      %figure(6)
hist(rr8,25); 
% axis([450 900 0 200]);
title('RR INTERVAL HISTOGRAM');%rr间隔直方图
xlabel('RR interval (ms)');
ylabel('interval numbers');
k1=length(rr3);
rr4=rr3(2:k1); 
rr5=rr3(1:k1-1);
rr6=rr4-rr5;
%%
figure;       %figure(7)
hist(rr6,25); 
% axis([-400 400 0 500]);
title('THE HISTOGRAM OF RR INTERVAL DIFFERENCE');
xlabel('RR interval difference (ms)');
ylabel('interval numbers');
figure;       %figure(8)   
plot(rr5,rr4,'r*') %plot  R-R(n)(X-Axis) vs R-R(n-1)(Y-Axis)
title('SCATTER DIAGRAM'), xlabel('RnRn+1 (ms)') ,ylabel('Rn+1Rn+2 (ms)')
% axis([0 1400 0 1400]);
%% 时域
out1=SDNN(rr8);
disp(['SDNN = ' num2str(out1)]);
out2=HRVindex(rr8);
disp(['HRVindex = ' num2str(out2)]);
out3=SDANN(rr8);
disp(['SDANN = ' num2str(out3)]);
out4=RMSSD(rr8);
disp(['RMSSD = ' num2str(out4)]);
out5=SDNNindex(rr8);
disp(['SDNNindex = ' num2str(out5)]);
out6=SDSD(rr8);
disp(['SDSD = ' num2str(out6)]);
out7=NN50count(rr8);
disp(['NN50 = ' num2str(out7)]);
out8=pNN50(rr8);
disp(['pNN50 = ' num2str(out8)]);
out9=TINN(rr8);
disp(['TINN = ' num2str(out9)]);
%% 频域
% A1=HF(rr8);
% disp(['HF = ' num2str(A1)]);
% A2=HFn(rr8);
% disp(['HFn = ' num2str(A2)]);
% A3=LF(rr8);
% disp(['LF = ' num2str(A3)]);
% A4=LFdividesHF(rr8);
% disp(['LFdividesHF = ' num2str(A4)]);
% A5=LFn(rr8);
% disp(['LFn = ' num2str(A5)]);
% A6=VLF(rr8);
% disp(['VLF = ' num2str(A6)]);
% A7=totalpower(rr8);
% disp(['totalpower = ' num2str(A7)]);





