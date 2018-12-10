function [R]=R_detect(X)   %差分阈值法特征点检测
%确定QRS波群
for n=2:323598
    Y1(n)=X(n+1)-X(n-1);          %一阶导数
end
for n=3:323599
    Y2(n)=X(n+2)-2*X(n)+X(n-2);   %二阶导数
end
max1=max(Y1);
max2=max(Y2);
for n=3:323598
    Y3(n)=max1*Y1(n)+max2*Y2(n);
end
a=0.25;
max3=max(Y3);
for i=3:323598
    if (abs(Y3(i))>max3*a)
       Y4(i)=1;
    else
       Y4(i)=0;
    end
end


%对Y4的处理1，去毛刺
for i=4:323597
    if (Y4(i)==1&&Y4(i-1)==0&&Y4(i+1)==0)
        Y4(i)=0;
    end
end


%对Y4的处理2，使QRS波群范围内一阶导数全为1，无“零点”，最终确定QRS波群
L=280;                          %窗口大小，根据两个R峰之间的点数来确定
for i=3:323542
    if (Y4(i)==0&&Y4(i-1)==1)
        for j=1:L/5
            if Y4(i+j)==1
               Y4(i)=1;
               break;
            end
        end
    end
end
for i=323598:-1:323542
    if Y4(i)==1
        for j=322543:i
            Y4(j)=1;
        end
        break;
    end
end


%确定R峰
B=[];
for i=4:323597                  %找出QRS波群的起始点
    if (Y4(i)==1&&Y4(i-1)==0)
        B=[B,i];
    elseif (Y4(i)==1&&Y4(i+1)==0)
        B=[B,i];
    end
end
s=size(B);
R=[];
for j=1:2:s(2)
     a=B(j);
     b=B(j+1);
    [maxR,r0]=max(X(1,a:b));  %找出QRS波群内幅值最大的一点，即为R峰
     r=a+r0-1;                %得出的最大值的位置是以a开头向后数（R0-1）位
     R=[R,r]; 
end
end
