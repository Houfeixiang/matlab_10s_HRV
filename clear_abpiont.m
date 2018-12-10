function [hr] = clear_abpiont(temp_hrv)
std_hrv=std(temp_hrv);
mean_hrv=mean(temp_hrv);
hr=[];
N=length(temp_hrv);
for i=1:N;
    if(abs(temp_hrv(i)-mean_hrv)<30000000)%mean_hrv-3*std_hrv
       hr(i)=temp_hrv(i) ;
       i=i+1;
    else
       hr(i)= mean_hrv;
       i=i+1;
    end;
end
end
