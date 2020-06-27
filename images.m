function [k]=images(date,x,sig,pt,nk)

for i = 1:size(nk,1)
    
    k=figure;
    suptitle('DCC(1,1)-GARCH(1,1)')
    subplot(3,1,1);
    plot(date(2:end),x(:,nk(i,1))*100,'k')
    grid on
    hold on
    plot(date(2:end),sqrt(sig(:,nk(i,1)))*100,'-r')
    axis tight
    ylabel('Returns %')
    
    subplot(3,1,2);
    plot(date(2:end),x(:,nk(i,2))*100,'k')
    grid on
    hold on
    plot(date(2:end),sqrt(sig(:,nk(i,2)))*100,'-r')
    axis tight
    ylabel('Returns %')
    
    subplot(3,1,3);
    plot(date(2:end),pt(:,i))
    grid on
    axis tight
    xlabel('Time')
    ylabel('\rho_{t}')
    set(get(gca,'ylabel'),'rotation',0)
    
    figure(k);
    
end