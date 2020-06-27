%% MAIN
%% Load files.mat
load CRI.mat ;
load Date.mat ;
load PW.mat ;

filename='Data 18x18 waverage.xlsx';

%% Nx270 Matrix
M270=CRI;

[DIFF270]=differing(M270);     % take the first difference
M270=DIFF270;                  % whole sample
M270FC=DIFF270(1:762,:);       % Financial crisis
M270EDC=DIFF270(763:1788,:);   % European debt crisis
M270L3Y=DIFF270(2304:3070,:);  % Last 3 years

%% Pearson Correlation Model 270x270
PCC270=corrcoef(M270);          % whole sample
PCC270FC=corrcoef(M270FC);      % Financial crisis
PCC270EDF=corrcoef(M270EDC);    % European debt crisis
PCC270L3Y=corrcoef(M270L3Y);    % Last 3 years


%% Nx18 Matrix
M18 = xlsread(filename);

[DIFF18]=differing(M18);     % take the first difference
M18 = DIFF18;                % whole sample
M18FC = DIFF18(1:762,:);     % Financial crisis
M18EDC = DIFF18(763:1788,:); % European debt crisis
M18L3Y=DIFF18(2304:3070,:);  % Last 3 years

%% Pearson Correlation Model 18x18 
PCC18=corrcoef(M18);         % whole sample
PCC18FC=corrcoef(M18FC);     % Financial crisis
PCC18EDF=corrcoef(M18EDC);   % European debt crisis
PCC18L3Y=corrcoef(M18L3Y);   % Last 3 years

%% DCC model applied to 18
%% APARCH estimation
[theta1,sig1,v1,nk1]=APARCHest(M18);  
[theta2,sig2,v2,nk2]=APARCHest(M18FC);
[theta3,sig3,v3,nk3]=APARCHest(M18EDC);
[the2ta4,sig4,v4,nk4]=APARCHest(M18L3Y);

%% DCC estimation
[delta1,pt1]=DCCest(v1,nk1);
[delta2,pt2]=DCCest(v2,nk2);
[delta3,pt3]=DCCest(v3,nk3);
[delta4,pt4]=DCCest(v4,nk4);

%% Corr Matrix 18x18 based on DCC model
nc=18;
DCC18=CorrM(pt1,nc);                        % whole sample
DCC18FC=CorrM(pt1,nc);                    % Financial crisis
DCC18EDF=CorrM(pt2,nc);                   % European debt crisis
DCC18L3Y=CorrM(pt3,nc);                   % Last 3 years

%% Difference between DCC model and Pearson correlation model
[DCorrs18]=diffCoer(M18,pt1,nc);
[DCorrs18FC]=diffCoer(M18FC,pt1,nc);
[DCorrs18EDF]=diffCoer(M18EDC,pt2,nc);
[DCorrs18L3Y]=diffCoer(M18L3Y,pt3,nc);

alpha=[0.1 0.05 0.01];

for i=1:size(DIFF270,2)
    for j = 1:size(alpha,2)
        [h1(i,j),pValue1(i,j)] = adftest(DIFF270(:,i),'alpha', alpha(1,j));
    end
end

for i=1:size(M18FC,2)
    for j = 1:size(alpha,2)
        [h2(i,j),pValue2(i,j)] = adftest(DIFF18(:,i),'alpha', alpha(1,j));
    end
end

%% List for correlations plots

j={'Swap-AT','Swap-BE','Swap-CZ','Swap-DE','Swap-DK','Swap-ES','Swap-FI','Swap-FR','Swap-HR','Swap-HU','Swap-IE','Swap-IT','Swap-NL','Swap-PT','Swap-SI','Swap-SK','Swap-SW','AT-BE','AT-CZ','AT-DE','AT-DK','AT-ES','AT-FI','AT-FR','AT-HR','AT-HU','AT-IE','AT-IT','AT-NL','AT-PT','AT-SI','AT-SK','AT-SW','BE-CZ','BE-DE','BE-DK','BE-ES','BE-FI','BE-FR','BE-HR','BE-HU','BE-IE','BE-IT','BE-NL','BE-PT','BE-SI','BE-SK','BE-SW','CZ-DE','CZ-DK','CZ-ES','CZ-FI','CZ-FR','CZ-HR','CZ-HU','CZ-IE','CZ-IT','CZ-NL','CZ-PT','CZ-SI','CZ-SK','CZ-SW','DE-DK','DE-ES','DE-FI','DE-FR','DE-HR','DE-HU','DE-IE','DE-IT','DE-NL','DE-PT','DE-SI','DE-SK','DE-SW','DK-ES','DK-FI','DK-FR','DK-HR','DK-HU','DK-IE','DK-IT','DK-NL','DK-PT','DK-SI','DK-SK','DK-SW','ES-FI','ES-FR','ES-HR','ES-HU','ES-IE','ES-IT','ES-NL','ES-PT','ES-SI','ES-SK','ES-SW','FI-FR','FI-HR','FI-HU','FI-IE','FI-IT','FI-NL','FI-PT','FI-SI','FI-SK','FI-SW','FR-HR','FR-HU','FR-IE','FR-IT','FR-NL','FR-PT','FR-SI','FR-SK','FR-SW','HR-HU','HR-IE','HR-IT','HR-NL','HR-PT','HR-SI','HR-SK','HR-SW','HU-IE','HU-IT','HU-NL','HU-PT','HU-SI','HU-SK','HU-SW','IE-IT','IE-NL','IE-PT','IE-SI','IE-SK','IE-SW','IT-NL','IT-PT','IT-SI','IT-SK','IT-SW','NL-PT','NL-SI','NL-SK','NL-SW','PT-SI','PT-SK','PT-SW','SI-SK','SI-SW','SK-SW'};

for i=1:length(j)

suptitle(sprintf('%s \n APARCH(1,1)-DCC(1,1)',j{1,i}))    
plot(Date(2489:end,1),pt4(2:end,i),'k')
hold on
plot(Date(2489:end,1),zeros(size(pt4(2:end,1),1),1),'--r')
grid minor
xlabel('Time')
ylabel('\rho_{t}')
xlim([Date(2489,1) Date(end,1)])
set(get(gca,'ylabel'),'rotation',0)
legend(sprintf('\\rho_{t,%s_{credit}}',j{1,i}))
thisfig = figure(i+1);
saveas(i,sprintf('%d.jpg',i));

end


%% List for correlations plots


suptitle('APARCH(1,1)-DCC(1,1)') 
subplot(2,2,1)
plot(Date(2489:end,1),pt4(2:end,69))
hold on
plot(Date(2489:end,1),pt4(2:end,113))
hold on
plot(Date(2489:end,1),pt4(2:end,72))
hold on
plot(Date(2489:end,1),zeros(size(pt4(2:end,1),1),1),'--r')
grid minor
xlabel('Time')
ylabel('\rho_{t}')
xlim([Date(2489,1) Date(end,1)])
set(get(gca,'ylabel'),'rotation',0)
legend(sprintf('\\rho_{t,%s_{credit}}',j{1,69}),sprintf('\\rho_{t,%s_{credit}}',j{1,113}),sprintf('\\rho_{t,%s_{credit}}',j{1,72}))

subplot(2,2,2)
plot(Date(2489:end,1),pt4(2:end,58))
hold on
plot(Date(2489:end,1),pt4(2:end,63))
hold on
plot(Date(2489:end,1),pt4(2:end,34))
hold on
plot(Date(2489:end,1),zeros(size(pt4(2:end,1),1),1),'--r')
grid minor
xlabel('Time')
ylabel('\rho_{t}')
xlim([Date(2489,1) Date(end,1)])
set(get(gca,'ylabel'),'rotation',0)
legend(sprintf('\\rho_{t,%s_{credit}}',j{1,58}),sprintf('\\rho_{t,%s_{credit}}',j{1,63}),sprintf('\\rho_{t,%s_{credit}}',j{1,34}))

subplot(2,2,3)
plot(Date(2489:end,1),pt4(2:end,73))
hold on
plot(Date(2489:end,1),pt4(2:end,56))
hold on
plot(Date(2489:end,1),pt4(2:end,140))
hold on
plot(Date(2489:end,1),zeros(size(pt4(2:end,1),1),1),'--r')
grid minor
xlabel('Time')
ylabel('\rho_{t}')
xlim([Date(2489,1) Date(end,1)])
set(get(gca,'ylabel'),'rotation',0)
legend(sprintf('\\rho_{t,%s_{credit}}',j{1,73}),sprintf('\\rho_{t,%s_{credit}}',j{1,56}),sprintf('\\rho_{t,%s_{credit}}',j{1,140}))

subplot(2,2,4)
plot(Date(2489:end,1),pt4(2:end,76))
hold on
plot(Date(2489:end,1),pt4(2:end,134))
hold on
plot(Date(2489:end,1),pt4(2:end,68))
hold on
plot(Date(2489:end,1),zeros(size(pt4(2:end,1),1),1),'--r')
grid minor
xlabel('Time')
ylabel('\rho_{t}')
xlim([Date(2489,1) Date(end,1)])
set(get(gca,'ylabel'),'rotation',0)
legend(sprintf('\\rho_{t,%s_{credit}}',j{1,76}),sprintf('\\rho_{t,%s_{credit}}',j{1,134}),sprintf('\\rho_{t,%s_{credit}}',j{1,68}))

%% Descriptive statistics
%2007-2019
for i=1:size(M18,2)
    M1(:,i)=mean(M18(:,i));
    sd1(:,i)=std(M18(:,i));
    Skew1(:,i)=skewness(M18(:,i));
    Kurt1(:,i)=kurtosis(M18(:,i));
    Max1(:,i)=max(M18(:,i));
    Min1(:,i)=min(M18(:,i));
    JB1(:,i)=min(M18(:,i));

end

tabled1=[M1',sd1',Skew1',Kurt1',Max1',Min1',JB1'];

%20010-2014
for i=1:size(M18FC,2)
    M2(:,i)=mean(M18FC(:,i));
    sd2(:,i)=std(M18FC(:,i));
    Skew2(:,i)=skewness(M18FC(:,i));
    Kurt2(:,i)=kurtosis(M18FC(:,i));
    Max2(:,i)=max(M18FC(:,i));
    Min2(:,i)=min(M18FC(:,i));
    JB2(:,i)=min(M18FC(:,i));

end

tabled2=[M2',sd2',Skew2',Kurt2',Max2',Min2',JB2'];


%2014-2016
for i=1:size(M18EDC,2)
    M3(:,i)=mean(M18EDC(:,i));
    sd3(:,i)=std(M18EDC(:,i));
    Skew3(:,i)=skewness(M18EDC(:,i));
    Kurt3(:,i)=kurtosis(M18EDC(:,i));
    Max3(:,i)=max(M18EDC(:,i));
    Min3(:,i)=min(M18EDC(:,i));
    JB3(:,i)=min(M18EDC(:,i));
end

tabled3=[M3',sd3',Skew3',Kurt3',Max3',Min3',JB3'];

%2016-2019
for i=1:size(M18L3Y,2)
    M4(:,i)=mean(M18L3Y(:,i));
    sd4(:,i)=std(M18L3Y(:,i));
    Skew4(:,i)=skewness(M18L3Y(:,i));
    Kurt4(:,i)=kurtosis(M18L3Y(:,i));
    Max4(:,i)=max(M18L3Y(:,i));
    Min4(:,i)=min(M18L3Y(:,i));
    JB4(:,i)=min(M18L3Y(:,i));
end

tabled4=[M4',sd4',Skew4',Kurt4',Max4',Min4',JB4'];


