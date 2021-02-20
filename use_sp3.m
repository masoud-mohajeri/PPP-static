clc
clear 
close all
format longg 
% %%
load('sp3.mat')
load('save1.mat')
load('pr1_R.mat')
load('e2r.mat')
%%
% load('Xss.mat')
% load('dtS.mat')
%%
t_obs1 = 5.643884370000362e+05 ;
%%
tow = t_obs1 + Xss(:,1) - dtS(:,3) - bdelta_t -19 ;
prn = Xss(:,2) ;
toe = sp3(:,1) ;
svid = sp3(:,2) ;
sco_sp3  = sp3(:,6) ;
%% sp2use
[sp3_use,error_eph] = sp2use(toe,svid,tow,prn,900) ;
rco = sco_sp3(sp3_use(:,1)) ;

for i =1:length(tow) 
    satelite(i,1) = inpol(toe(sp3_use(i,1)) , sp3(sp3_use(i,1),3) , toe(sp3_use(i,2)) , sp3(sp3_use(i,2),3) , tow(i)) ;
    satelite(i,2) = inpol(toe(sp3_use(i,1)) , sp3(sp3_use(i,1),4) , toe(sp3_use(i,2)) , sp3(sp3_use(i,2),4) , tow(i)) ;
    satelite(i,3) = inpol(toe(sp3_use(i,1)) , sp3(sp3_use(i,1),5) , toe(sp3_use(i,2)) , sp3(sp3_use(i,2),5) , tow(i)) ;
end


%% liner interpolation 
% save('sp3_cords.mat','satelite','rco')
for i =1:length(Xss)
    gerror(i,1) = sqrt((satelite(i,1)-Xss(i,3))^2 +(satelite(i,2)-Xss(i,4))^2 +(satelite(i,3)-Xss(i,5))^2 ) ;
end
% % terror = dtS(:,3) - rco ; 



figure()
for i =1:5200
    if prn(i) == 7
        plot3(Xss(i,3),Xss(i,4),Xss(i,5),'r.')
        hold on 
        plot3(satelite(i,1),satelite(i,2),satelite(i,3),'k.')
    end
end
plot3(sp3(1639,3),sp3(1639,4),sp3(1639,5),'k')
plot3(sp3(1671,3),sp3(1671,4),sp3(1671,5),'kh')
plot3(sp3(1607,3),sp3(1607,4),sp3(1607,5),'kh')
%% 2nd degree polynomial
for i=1:length(sp3_use)
    t_obs = tow(i) ;
    datai = [sp3(sp3_use(i,1),1),sp3(sp3_use(i,1),3:5) ;...
             sp3(sp3_use(i,2),1),sp3(sp3_use(i,2),3:5) ;...
             sp3(sp3_use(i,3),1),sp3(sp3_use(i,3),3:5) ] ;
         
         ia_mat = inv([datai(1,1)^2 ,datai(1,1) , 1 ;...
                       datai(2,1)^2 ,datai(2,1) , 1 ;...
                       datai(3,1)^2 ,datai(3,1) , 1 ]) ;
    for j=1:3
        l_mat = datai(:,j+1) ;
        x_mat = ia_mat*l_mat ;
        satelite2(i,j) = x_mat'*[t_obs^2 ; t_obs ; 1 ] ; 
    end   
end


figure()
for i =1:5200
    if prn(i) == 7
        plot3(Xss(i,3),Xss(i,4),Xss(i,5),'r.')
        hold on 
        plot3(satelite2(i,1),satelite2(i,2),satelite2(i,3),'g.')
        hold on 
    end
end
plot3(sp3(1639,3),sp3(1639,4),sp3(1639,5),'kh')
plot3(sp3(1671,3),sp3(1671,4),sp3(1671,5),'kh')
plot3(sp3(1607,3),sp3(1607,4),sp3(1607,5),'kh')


for i =1:length(Xss)
    gerror2(i,1) = sqrt((satelite2(i,1)-Xss(i,3))^2 +(satelite2(i,2)-Xss(i,4))^2 +(satelite2(i,3)-Xss(i,5))^2 ) ;
end



t = 0  ;
figure()
for i =1:5200
    if prn(i) == 7
                t = t + 1 ;

stem(t,gerror(i),'r')
hold on 
stem(t,gerror2(i),'k+')
    end
end

% t = 0  ;
% figure()
% for i =1:5200
%     if prn(i) == 7
%         t = t + 1 ;
%         stem(t,gerror(i)-gerror2(i))
%         hold on
%     end
% end

%% lagrange 
for i=1:length(prn)
    t_obs = tow(i) ;
    datai = [sp3(sp3_use(i,1),1),sp3(sp3_use(i,1),3:5) ;...
             sp3(sp3_use(i,2),1),sp3(sp3_use(i,2),3:5) ;...
             sp3(sp3_use(i,3),1),sp3(sp3_use(i,3),3:5) ] ;
    satelite3(i,1) = lagrange(t_obs,datai(:,1),datai(:,2)) ;
    satelite3(i,2) = lagrange(t_obs,datai(:,1),datai(:,3)) ;
    satelite3(i,3) = lagrange(t_obs,datai(:,1),datai(:,4)) ;
end

for i =1:length(Xss)
    gerror3(i,1) = sqrt((satelite3(i,1)-Xss(i,3))^2 +(satelite3(i,2)-Xss(i,4))^2 +(satelite3(i,3)-Xss(i,5))^2 ) ;
end

figure()
for i =1:5200
    if prn(i) == 7
        plot3(Xss(i,3),Xss(i,4),Xss(i,5),'r.')
        hold on 
        plot3(satelite3(i,1),satelite3(i,2),satelite3(i,3),'g.')
        hold on 
    end
end
plot3(sp3(1639,3),sp3(1639,4),sp3(1639,5),'kh')
plot3(sp3(1671,3),sp3(1671,4),sp3(1671,5),'kh')
plot3(sp3(1607,3),sp3(1607,4),sp3(1607,5),'kh')








%%
sp4.data = zeros(size(sp3));
sp4.data(:,4) = sp3(:,3) ;
sp4.data(:,5) = sp3(:,4) ;
sp4.data(:,6) = sp3(:,5) ;
sp4.data(:,2) = sp3(:,1) ;
sp4.data(:,3) = sp3(:,2) ;
figure()
for i =1:length(tow)
    XYZpos(i,:) = precise_orbit_interp(tow(i), prn(i), sp4,1) ;
end

XYZpos = XYZpos/1000;


for i =1:length(Xss)
    gerror4(i,1) = sqrt((XYZpos(i,1)-Xss(i,3))^2 +(XYZpos(i,2)-Xss(i,4))^2 +(XYZpos(i,3)-Xss(i,5))^2 ) ;
end


%%
figure()
subplot(2,4,1)
plot3(satelite(:,1),satelite(:,2),satelite(:,3),'r.')
hold on 
plot3(Xss(:,3),Xss(:,4),Xss(:,5),'g.')
title('liner')
subplot(2,4,2)
plot3(satelite2(:,1),satelite2(:,2),satelite2(:,3),'r.')
hold on 
plot3(Xss(:,3),Xss(:,4),Xss(:,5),'g.')
title('2nd deg. polynomial')
subplot(2,4,3)
plot3(satelite3(:,1),satelite3(:,2),satelite3(:,3),'r.')
hold on 
plot3(Xss(:,3),Xss(:,4),Xss(:,5),'g.')
title('Lagrange')
subplot(2,4,4)
plot3(XYZpos(:,1),XYZpos(:,2),XYZpos(:,3),'r.')
hold on 
plot3(Xss(:,3),Xss(:,4),Xss(:,5),'g.')
title('Code')



subplot(2,4,5)
plot(gerror,'.')
subplot(2,4,6)
plot(gerror2,'.')
subplot(2,4,7)
plot(gerror3,'.')
subplot(2,4,8)
plot(gerror4,'.')

Xss3 = [Xss(:,1:2) , XYZpos ] ; 

save('Xss3.mat','Xss3')









