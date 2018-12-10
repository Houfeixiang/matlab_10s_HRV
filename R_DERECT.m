clc;
close all;
ecg=load('E:\课题\matlab程序1\HECG1.txt');
f_s=128;
N=length(ecg);
t=(0:N-1)/f_s; %时间段（总样本数/ Fs）
figure(1);
plot(t,ecg,'r'); title('原始数据图像 ')             
xlabel('时间')
ylabel('幅值')
w=50/(128/2);
bw=w;
[num,den]=iirnotch(w,bw); %  陷波滤波器
ecg_notch=filter(num,den,ecg);
[e,f]=wavedec(ecg_notch,10,'db6');% 小波实现
g=wrcoef('a',e,f,'db6',8); 
ecg_wave=ecg_notch-g; % subtracting 10th level aproximation signal
                      %from original signal                  
ecg_smooth=smooth(ecg_wave); % using average filter to remove glitches平均滤波器去毛刺
                             %to increase the performance of peak detection 

N1=length(ecg_smooth);
t1=(0:N1-1)/f_s;
figure(2);
plot(t1,ecg_smooth),ylabel('幅值'),xlabel('时间')
title('滤波后的ECG信号')

d=ecg;ECG=d(:,1);x=ECG(1:128);
y=fft(x,128);
mag=abs(y);
f=2*pi/128:2*pi/128:2*pi;
figure(3);
plot(f,mag);
%axis([0,100,0,7]);
xlabel('频率'); ylabel('幅值');
title('原始心电频谱图');

z=ecg_smooth;ECG=z(:,1);x=ECG(1:128);
y=fft(x,128);
mag=abs(y);
f=2*pi/128:2*pi/128:2*pi;
figure(4);
plot(f,mag);
%axis([0,7,0,100]);
xlabel('频率'); ylabel('幅值');
title('滤波后心电频谱图');

% Peak detection algorithm峰值检测算法 
% For more detailsor detailed explanation on this look into 
% Matlab for beginers 

hh=ecg_smooth;
 j=[];           %loop initialing, having all the value zero in the array
time=0;          %loop initialing, having all the value zero in the array 初始化数组中数据置为零
th=0.45*max(hh);  %thresold setting at 45 percent of maximum value阈值设置为最大值的45％

for i=2:N1-1 % length selected for comparison  长度被选择用于比较首先进行比较，
    % deopping first ie i=1:N-1  point because hh(1-1) 即i = 1：N-1点，因为下一行中的hh（1-1）将是0，
   % in the next line  will be zero which is not appreciable in matlab 这在matlab中是不可估计的
    if((hh(i)>hh(i+1))&&(hh(i)>hh(i-1))&&(hh(i)>th))  
% condition, i should be> then previous(i-1),next(i+1),thrsold point;
        j(i)=hh(i);                                   
    %如果条件满足存储hh（i），代替j（i）最初为0的值   
        time(i)=(i-1)/128;           %position stored where peak value met;存储在峰值达到的位置;              
      
    end
end
 j(j==0)=[];               % neglect all zeros from array;忽略数组中的所有零;
 time(time==0)=[];     % neglect all zeros from array;
m=(time)';               % converting rows in column;转换列中的行;
k=length(m);
figure(5);
plot(t,hh);            %x-axis time, y-smooth signal value;
hold on;% hold the plot and wait for next instruction;
plot(time,j,'*','color','r')
title('心电信号中检测到的峰值点')    
%x-axis time, yaxis-peak value,r=marker;x轴时间，y轴峰值，r =标记
xlabel('时间')
ylabel('幅值')
hold off                 % instruction met;
%%  Task 4-a
%从变量j和时间中删除不需要的零
rr2=[m(2:k)]*1000;     %s从第二点到最后一点的第二个数组;
rr1=[m(1:k-1)]*1000;   %从第一到第二个最后一个点的第一个数组
                       % rr2＆rr1现在是等长的;
rr3=rr2-rr1;
%fid=fopen('rr3.txt','wt');
%fprintf(fid,'%g\n',rr3);
%fclose(fid);
rr7= clear_abpiont(rr3);
rr8=(rr7');
hr=60000./rr8;         % computate heart rate variation ;计算心率
%rr33=(rr3)';
figure(6);
hist(rr8,25); 
title('RR间期直方图');
axis([400 1000 0 200]);
ki=length(rr7);
rr4=rr7(2:ki); 
rr5=rr7(1:ki-1);
rr6=rr4-rr5;
figure(7);
hist(rr6,25); 
title('RR间期差值直方图')
axis([-150 150 0 200]);
figure(8);
plot(rr5,rr4,'r*') %plot  R-R(n)(X-Axis) vs R-R(n-1)(Y-Axis)
title('散点图'), xlabel('RnRn+1') ,ylabel('Rn+1 Rn+2')
axis([0 2000 0 2000]);
 %% 时域参数
ki=length(rr8) ;
ahr=mean(hr);       % mean heart rate;
disp(['mean hr = ' num2str(ahr)]); 
% disp is used to display the value(s);
MEAN=mean(rr8);
disp(['MEAN = ' num2str(MEAN)]);
SDNN = std(rr8,1); 
% SDNN, standard deviation for RR interval used in statical analysis;
disp(['SDNN = ' num2str(SDNN)]);
%sq = diff(rr7).^2;
%rms = sqrt(mean(sq)); % RMSSD,
RMSSD=sqrt(mean(rr6.^2));
%disp(['RMSSD = ' num2str(RMSSD)]);  
% RMS difference for RR interval used in statical analysis; 
NN50 = sum(abs(diff(rr8))>50); 
pNN50=(NN50/length(rr8))*100;
disp(['NN50 = ' num2str(NN50)]);
disp(['pNN50 = ' num2str(pNN50)]);

%% 频域分析

