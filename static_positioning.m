function [a_mat,l_mat,x_mat,loc] = static_positioning(Xss,pr1_R,obs_error,weight)
tow = Xss(:,1) ;
unitow = zeros(size(unique(tow),1),2) ;
unitow(:,1) = unique(tow) ;
for i=1:length(unitow)
    for j=1:length(tow)
        if tow(j) == unitow(i,1)
            unitow(i,2) = unitow(i,2) + 1 ;
        end
    end
end
reciver_co = zeros(length(tow),length(unitow)) ;
t = 0 ;
for i=1:length(unitow)
    reciver_co(t+1:t+unitow(i,2),i) = 1 ;
    t = t+unitow(i,2) ;
end
clear t
error = 1 ;
loc = [ 0 0 0 ] ;
iter = 0 ;
while error > 1e-6
    for j=1:length(Xss)
        ro0 = sqrt( (loc(1)-Xss(j,3))^2 +...
            (loc(2)-Xss(j,4))^2 +...
            (loc(3)-Xss(j,5))^2 ) ;
        a_mat(j,1:3) = [(loc(1)-Xss(j,3))/ro0,...
            (loc(2)-Xss(j,4))/ro0,...
            (loc(3)-Xss(j,5))/ro0 ] ;
        l_mat(j,:) = pr1_R(Xss(j,2),Xss(j,1)) + obs_error(j,3) -ro0 ;
    end
    if iter == 0
        a_mat = [a_mat , reciver_co ] ;
    end
    x_mat = inv(a_mat'*weight*a_mat)*a_mat'*weight*l_mat ;
    loc(1) = loc(1) + x_mat(1) ;
    loc(2) = loc(2) + x_mat(2) ;
    loc(3) = loc(3) + x_mat(3) ;
    error = sqrt(x_mat(1)^2 + x_mat(2)^2 + x_mat(3)^2 ) ;
    iter = iter + 1 ;
end

for j=1:length(Xss)
    ro0 = sqrt( (loc(1)-Xss(j,3))^2 +...
        (loc(2)-Xss(j,4))^2 +...
        (loc(3)-Xss(j,5))^2 ) ;
    a_mat(j,1:3) = [(loc(1)-Xss(j,3))/ro0,...
        (loc(2)-Xss(j,4))/ro0,...
        (loc(3)-Xss(j,5))/ro0 ] ;
    l_mat(j,:) = pr1_R(Xss(j,2),Xss(j,1)) + obs_error(j,3) -ro0 ;
    
end



end