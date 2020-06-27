%% 1.Read Data
[~,sheet_name]=xlsfinfo('Interest rate risk input Vu.xlsx');

for k=2:2
    sheet{k}=xlsread('Interest rate risk input Vu.xlsx',sheet_name{k});
    
end

for k=21:numel(sheet_name)
    
  sheet{k}=xlsread('Interest rate risk input Vu.xlsx',sheet_name{k});
  
end;
%% Portfolio weights
PW=sheet{1,38};

%% 2. Relevant maturities from Zero Sheet
sheet{1,2}(:,2) = [];
sheet{1,2}(:,2) = [];
sheet{1,2}(:,4) = [];
sheet{1,2}(:,14) = [];
sheet{1,2}(:,14) = [];
sheet{1,2}(:,14) = [];
sheet{1,2}(:,14) = [];

sheet{1,2}(:,15) = [];
sheet{1,2}(:,15) = [];
sheet{1,2}(:,15) = [];
sheet{1,2}(:,15) = [];

sheet{1,2}(:,16) = [];
sheet{1,2}(:,16) = [];
sheet{1,2}(:,16) = [];
sheet{1,2}(:,16) = [];
sheet{1,2}(:,16) = [];
sheet{1,2}(:,16) = [];
sheet{1,2}(:,16) = [];
sheet{1,2}(:,16) = [];
sheet{1,2}(:,16) = [];
%}
%% 3.Convert sheets to tables object
for k=2:2
    sheet{1,k} = array2table(sheet{1,k});
end

for k=21:numel(sheet_name)
    sheet{1,k} = array2table(sheet{1,k});
end

%% 4.Convert Excel Date to Matlab date format
for k=2:2
    sheet{1,k}.(1) = datetime(sheet{1,k}.(1), 'ConvertFrom', 'Excel', 'Format', 'MM/dd/yy');
end

for k=21:numel(sheet_name)-1
    sheet{1,k}.(1) = datetime(sheet{1,k}.(1), 'ConvertFrom', 'Excel', 'Format', 'MM/dd/yy');
end
    

%% 5.Convert table object to timetable object

for k=2:2
    sheet{1,k} = table2timetable(sheet{1,k});
end

for k=21:numel(sheet_name)-1
    sheet{1,k} = table2timetable(sheet{1,k});
end

%% Convert timetable to table to sheet
sheet{21,1}=synchronize(sheet{1,2},sheet{1,21},'intersection');

for j=22:numel(sheet_name)-1
    sheet{j,1}=synchronize(sheet{j-1,1},sheet{1,j},'intersection');
end

SyncTable = sheet{numel(sheet_name)-1,1};
Table = timetable2table(rmmissing(SyncTable));

%% Parsed data
CRI=table2array(Table(:, 2:end));
Date=table2array(Table(:,1));
%% Save files
filename1='CRI.mat';
filename2='Date.mat';
filename3='PW.mat';
save(filename1,'CRI');
save(filename2,'Date');
save(filename3,'PW');
