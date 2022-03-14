%% Contour Training data Analysis - Distractor information

clear all
close all
clc

%% Looping through every file in the directory - Individual and Summary

% Piecing out the distractor information presented to the participants
% during each session

% files = dir('*.json');
% count = 1;
% part_cmp = 'STS1002';
% count_odd = 0;
% for i = 1:length(files)
%     [~,names] = fileparts(files(i).name);
%     cmp_name = names(end-9:end);
%     log_name = 'ContourLog';
%     part_name = names(1:7);
%     ses_name = names(10:11);
%     block_name = names(15);
%     run_name = names(18:19);
%     ses = str2double(regexp(ses_name,'\d*','match'));
%     run = str2double(regexp(run_name,'\d*','match'));
%     block = str2double(regexp(block_name,'\d*','match'));
%     if sum(part_name ~= part_cmp) > 0
%         count = count + 1;
%         part_cmp = part_name;
%         count_odd = 0;
%         if cmp_name == log_name
%             if block == 0
%                 count_odd = ses + 1;
%                 fname = (files(i).name);
%                 val = jsondecode(fileread(fname));
%                 NT{count,ses+count_odd}{1,run+1} = val.data;
%             else
%                 fname = (files(i).name);
%                 val = jsondecode(fileread(fname));
%                 NT{count,(ses+1)*2}{1,run+1} = val.data;
%             end
%         end
%     else
%         if cmp_name == log_name
%             if block == 0
%                 count_odd = ses + 1;
%                 fname = (files(i).name);
%                 val = jsondecode(fileread(fname));
%                 NT{count,ses+count_odd}{1,run+1} = val.data;
%             else
%                 fname = (files(i).name);
%                 val = jsondecode(fileread(fname));
%                 NT{count,(ses+1)*2}{1,run+1} = val.data;
%             end
%         end
%     end
% end

% save('NT_data', 'NT')

% fname = ('CA1002B_039_Summary.json');
%                     val = jsondecode(fileread(fname));
%                     Data_SP_30 = val.data;

files = dir('*.json');
count = 1;
part_cmp = 'STS1002';
for i = 1:length(files)
    [~,names] = fileparts(files(i).name);
    cmp_name = names(end-6:end);
    log_name = 'Summary';
    part_name = names(1:7);
    ses_name = names(10:11);
    %     run_name = names(18:19);
    ses = str2double(regexp(ses_name,'\d*','match'));
    %     run = str2double(regexp(run_name,'\d*','match'));
    if sum(part_name ~= part_cmp) > 0
        count = count + 1;
        part_cmp = part_name;
        if cmp_name == log_name
            fname = (files(i).name);
            val = jsondecode(fileread(fname));
            NT{count,ses+1}{1,run+1} = val.data;
        end
    else
%         if (sum(part_cmp ~= part_name) == 0)
            if (cmp_name == log_name)
                fname = (files(i).name);
                val = jsondecode(fileread(fname));
                NT_summary{count,ses+1} = val.data;
            end
%         end
    end
end
% 
% save('NT_summary', 'NT_summary')
%% Loading files
load('NT_data.mat');
load('NT_summary2.mat')
% load('NT_summary.mat');

% Organising the Summary file to account for 40 training sessions
% Contour = 'Contour';
% for i = 1:size(NT_summary,1)
%     for j = 1:size(NT_summary,2)
%         if i == 13 && j == 8
%             continue;
%         else
%             if ~isempty(NT_summary{i,j})
%                 count = 0;
%                 for k = 1:length(NT_summary{i,j})                    
%                     fields = fieldnames(NT_summary{i,j}{k,1});
%                     if contains(NT_summary{i,j}{k,1}.game_type, 'Contour')
%                         if NT_summary{i,j}{k,1}.element == 0
%                             dummy0{i,j}{k,1} = NT_summary{i,j}{k,1};
%                         else
%                             dummy2{i,j}{k,1} = NT_summary{i,j}{k,1};
%                         end
%                     end
%                 end
%             end
%         end
%     end
% end
% % Removing empty cells from the dummy2 matrices
% for i = 1:size(NT_summary,1)
%     for j = 1:size(NT_summary,2)
%         if ~isempty(dummy2{i,j})
%             bla = dummy2{i,j};
%             bla = bla(~cellfun('isempty', bla));
%             dummy2{i,j} = bla;
%         end
%     end
% end
% odd = 1:40;
% even = 1:40;
% % dum = 1:40;
% count1 = 0:0.5:19;
% for i = 1:size(dummy0,1)
%     for j = 1:40 %size(dummy0,2)
%         if mod(j,2) ~= 0
%             NT_summary2{i,odd(j)} = dummy0{i,j-count1(j)};  
%         else
%             NT_summary2{i,even(j)} = dummy2{i,j/2};
%         end
%     end
% end


Contour = 'Contour';
contour_class = 'contour_class';
Count = 'Count';
OrientationJitter = 'OrientationJitter';
% for i = 1:size(NT_summary2,1)
%     for j = 1:size(NT_summary2,2)
%         if (i == 5 && j == 6) || (i == 3 && j == 7) || (i == 15 && j == 8) || (i == 10 && j == 21)...
%                 || (i == 19 && j == 23)
%             continue;
%         else
%             if ~isempty(NT_summary2{i,j})
%                 count = 0;
%                 for k = 1:length(NT_summary2{i,j})
%                     fields = fieldnames(NT_summary2{i,j}{k,1});
%                     if contains(NT_summary2{i,j}{k,1}.game_type, 'Contour')
%                         if contains(NT_summary2{i,j}{k,1}.contour_parameter, 'Count')
%                             if contains(fields{5,1}, 'contour_class')
%                                 count = count + 1
%                                 class = NT_summary2{i,j}{k,1}.contour_class;
%                                 test{i,j}(count,1) = {class};
%                             end
%                         end
%                     end
%                 end
%             end
%         end
%         if ~isempty(test{i,j})
%             unique_class{i,j} = unique(test{i,j});
%         end
%     end
% end

%% Isolating data contour class - wise
% Circle_General = "Circle_General"; % 1
% Line_V = "Line_V"; % 2
% Line_H = "Line_H"; % 3
% Ellipse_V_Fixed = "Ellipse_V_Fixed"; % 4
% Ellipse_R_Fixed = "Ellipse_R_Fixed"; % 5
% Spiral_General = "Spiral_General"; % 6
% Blob_1 = "Blob_1"; % 7
% Blob_2 = "Blob_2"; % 8
% Blob_3 = "Blob_3"; % 9
% Blob_4 = "Blob_4"; % 10
% Blob_5 = "Blob_5"; % 11
% Blob_6 = "Blob_6"; % 12
% Blob_7 = "Blob_7"; % 13
% Blob_8 = "Blob_8"; % 14
% Blob_9 = "Blob_9"; % 15
% Blob_10 = "Blob_10"; % 16
% Squiggle_V_Locked_LC = "Squiggle_V_Locked_LC"; % 17
% Squiggle_H_Locked_LC = "Squiggle_H_Locked_LC"; % 18
% Squiggle_V_Locked = "Squiggle_V_Locked"; % 19
% Squiggle_H_Locked = "Squiggle_H_Locked"; % 20
% Squiggle_H_Roving = "Squiggle_H_Roving"; % 21
% Squiggle_V_Roving = "Squiggle_V_Roving"; % 22
% Squiggle_R_Roving = "Squiggle_R_Roving"; % 23
% Letter_B = "Letter_B"; % 24
% Letter_D = "Letter_D"; % 25
% Letter_P = "Letter_P"; % 26
% % Letter_Q = "Letter_Q"; % 27
% RandLetter = "RandLetter"; % 28
% RandClosed_Hard = "RandClosed_Hard"; % 29
% RandOpen = "RandOpen"; % 30
% 
% for i = 1:size(NT,1)
%     for j = 1:size(NT,2)
%         count1 = 0; count15 = 0;
%         count2 = 0; count16 = 0;
%         count3 = 0; count17 = 0;
%         count4 = 0; count18 = 0;
%         count5 = 0; count19 = 0;
%         count6 = 0; count20 = 0;
%         count7 = 0; count21 = 0;
%         count8 = 0; count22 = 0;
%         count9 = 0; count23 = 0;
%         count10 = 0; count24 = 0;
%         count11 = 0; count25 = 0;
%         count12 = 0; count26 = 0;
%         count13 = 0; count27 = 0;
%         count14 = 0; count28 = 0;
%         count29 = 0; count30 = 0;
% %         if (i == 5 && j == 6) || (i == 3 && j == 7) || (i == 15 && j == 8) || (i == 10 && j == 21)...
% %                 || (i == 19 && j == 23)
% %             continue;
% %         else
%             if ~isempty(NT_summary2{i,j})
%                 for k = 1:length(NT_summary2{i,j})
%                     if contains(NT_summary2{i,j}{k,1}.game_type, Contour)
%                         if contains(NT_summary2{i,j}{k,1}.contour_parameter, Count)
%                             run = NT_summary2{i,j}{k,1}.run + 1;
%                             if i == 3 && j > 36 || i == 9 && j > 38 || i == 10 && j == 31 || i == 13 && j == 15 || i == 13 && j == 16 
%                                 continue;
%                             else
%                                 if strcmp(NT_summary2{i,j}{k,1}.contour_class, Circle_General)
%                                     count1 = count1 + 1;
%                                     dist1{i,j}{count1,1} = NT{i,j}{1,run}; 
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Line_V)
%                                     count2 = count2 + 1;
%                                     dist2{i,j}{count2,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Line_H)
%                                     count3 = count3 + 1;
%                                     dist3{i,j}{count3,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Ellipse_V_Fixed)
%                                     count4 = count4 + 1;
%                                     dist4{i,j}{count4,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Ellipse_R_Fixed)
%                                     count5 = count5 + 1;
%                                     dist5{i,j}{count5,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Spiral_General)
%                                     count6 = count6 + 1;
%                                     dist6{i,j}{count6,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Blob_1)
%                                     count7 = count7 + 1;
%                                     dist7{i,j}{count7,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Blob_2)
%                                     count8 = count8 + 1;
%                                     dist8{i,j}{count8,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Blob_3)
%                                     count9 = count9 + 1;
%                                     dist9{i,j}{count9,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Blob_4)
%                                     count10 = count10 + 1;
%                                     dist10{i,j}{count10,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Blob_5)
%                                     count11 = count11 + 1;
%                                     dist11{i,j}{count11,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Blob_6)
%                                     count12 = count12 + 1;
%                                     dist12{i,j}{count12,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Blob_7)
%                                     count13 = count13 + 1;
%                                     dist13{i,j}{count13,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Blob_8)
%                                     count14 = count14 + 1;
%                                     dist14{i,j}{count14,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Blob_9)
%                                     count15 = count15 + 1;
%                                     dist15{i,j}{count15,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Blob_10)
%                                     count16 = count16 + 1;
%                                     dist16{i,j}{count16,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Squiggle_V_Locked_LC)
%                                     count17 = count17 + 1;
%                                     dist17{i,j}{count17,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Squiggle_H_Locked_LC)
%                                     count18 = count18 + 1;
%                                     dist18{i,j}{count18,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Squiggle_V_Locked)
%                                     count19 = count19 + 1;
%                                     dist19{i,j}{count19,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Squiggle_H_Locked)
%                                     count20 = count20 + 1;
%                                     dist20{i,j}{count20,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Squiggle_H_Roving)
%                                     count21 = count21 + 1;
%                                     dist21{i,j}{count21,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Squiggle_V_Roving)
%                                     count22 = count22 + 1;
%                                     dist22{i,j}{count22,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Squiggle_R_Roving)
%                                     count23 = count23 + 1;
%                                     dist23{i,j}{count23,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Letter_B)
%                                     count24 = count24 + 1;
%                                     dist24{i,j}{count24,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Letter_D)
%                                     count25 = count25 + 1;
%                                     dist25{i,j}{count25,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Letter_P)
%                                     count26 = count26 + 1;
%                                     dist26{i,j}{count26,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, RandLetter)
%                                     count27 = count27 + 1;
%                                     dist27{i,j}{count27,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, RandClosed_Hard)
%                                     count28 = count28 + 1;
%                                     dist28{i,j}{count28,1} = NT{i,j}{1,run};
%                                 else
%                                     count29 = count29 + 1;
%                                     dist29{i,j}{count29,1} = NT{i,j}{1,run};
%                                 end
%                             end
%                         end
%                     end
%                 end
%             end
% %         end
%     end
% end
% 
% save('dist1', 'dist1'); save('dist2', 'dist2'); save('dist3', 'dist3'); save('dist4', 'dist4'); save('dist5', 'dist5');
% save('dist6', 'dist6'); save('dist7', 'dist7'); save('dist8', 'dist8'); save('dist9', 'dist9'); save('dist10', 'dist10');
% save('dist11', 'dist11'); save('dist12', 'dist12'); save('dist13', 'dist13'); save('dist14', 'dist14'); %save('dist15', 'dist15'); 
% save('dist16', 'dist16'); save('dist17', 'dist17'); save('dist18', 'dist18'); 
% save('dist19', 'dist19'); save('dist20', 'dist20'); save('dist21', 'dist21'); save('dist22', 'dist22'); 
% save('dist23', 'dist23'); save('dist24', 'dist24'); save('dist25', 'dist25'); save('dist26', 'dist26'); 
% save('dist27', 'dist27'); save('dist28', 'dist28'); save('dist29', 'dist29'); %save('dist30', 'dist30'); 
% 
%% Extracting orientation Jitter Information
% for i = 1:size(NT,1)
%     for j = 1:size(NT,2)
%         count1 = 0; count15 = 0;
%         count2 = 0; count16 = 0;
%         count3 = 0; count17 = 0;
%         count4 = 0; count18 = 0;
%         count5 = 0; count19 = 0;
%         count6 = 0; count20 = 0;
%         count7 = 0; count21 = 0;
%         count8 = 0; count22 = 0;
%         count9 = 0; count23 = 0;
%         count10 = 0; count24 = 0;
%         count11 = 0; count25 = 0;
%         count12 = 0; count26 = 0;
%         count13 = 0; count27 = 0;
%         count14 = 0; count28 = 0;
%         count29 = 0; count30 = 0;
% %         if (i == 5 && j == 6) || (i == 3 && j == 7) || (i == 15 && j == 8) || (i == 10 && j == 21)...
% %                 || (i == 19 && j == 23)
% %             continue;
% %         else
%             if ~isempty(NT_summary2{i,j})
%                 for k = 1:length(NT_summary2{i,j})
%                     if contains(NT_summary2{i,j}{k,1}.game_type, Contour)
%                         if contains(NT_summary2{i,j}{k,1}.contour_parameter, OrientationJitter)
%                             run = NT_summary2{i,j}{k,1}.run + 1;
%                             if i == 3 && j > 36 || i == 9 && j > 38 || i == 10 && j == 31 || i == 13 && j == 15 || i == 13 && j == 16
%                                 continue;
%                             else
%                                 if strcmp(NT_summary2{i,j}{k,1}.contour_class, Circle_General)
%                                     count1 = count1 + 1;
%                                     distori1{i,j}{count1,1} = NT{i,j}{1,run}; 
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Line_V)
%                                     count2 = count2 + 1;
%                                     distori2{i,j}{count2,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Line_H)
%                                     count3 = count3 + 1;
%                                     distori3{i,j}{count3,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Ellipse_V_Fixed)
%                                     count4 = count4 + 1;
%                                     distori4{i,j}{count4,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Ellipse_R_Fixed)
%                                     count5 = count5 + 1;
%                                     distori5{i,j}{count5,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Spiral_General)
%                                     count6 = count6 + 1;
%                                     distori6{i,j}{count6,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Blob_1)
%                                     count7 = count7 + 1;
%                                     distori7{i,j}{count7,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Blob_2)
%                                     count8 = count8 + 1;
%                                     distori8{i,j}{count8,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Blob_3)
%                                     count9 = count9 + 1;
%                                     distori9{i,j}{count9,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Blob_4)
%                                     count10 = count10 + 1;
%                                     distori10{i,j}{count10,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Blob_5)
%                                     count11 = count11 + 1;
%                                     distori11{i,j}{count11,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Blob_6)
%                                     count12 = count12 + 1;
%                                     distori12{i,j}{count12,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Blob_7)
%                                     count13 = count13 + 1;
%                                     distori13{i,j}{count13,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Blob_8)
%                                     count14 = count14 + 1;
%                                     distori14{i,j}{count14,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Blob_9)
%                                     count15 = count15 + 1;
%                                     distori15{i,j}{count15,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Blob_10)
%                                     count16 = count16 + 1;
%                                     distori16{i,j}{count16,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Squiggle_V_Locked_LC)
%                                     count17 = count17 + 1;
%                                     distori17{i,j}{count17,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Squiggle_H_Locked_LC)
%                                     count18 = count18 + 1;
%                                     distori18{i,j}{count18,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Squiggle_V_Locked)
%                                     count19 = count19 + 1;
%                                     distori19{i,j}{count19,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Squiggle_H_Locked)
%                                     count20 = count20 + 1;
%                                     distori20{i,j}{count20,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Squiggle_H_Roving)
%                                     count21 = count21 + 1;
%                                     distori21{i,j}{count21,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Squiggle_V_Roving)
%                                     count22 = count22 + 1;
%                                     distori22{i,j}{count22,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Squiggle_R_Roving)
%                                     count23 = count23 + 1;
%                                     distori23{i,j}{count23,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Letter_B)
%                                     count24 = count24 + 1;
%                                     distori24{i,j}{count24,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Letter_D)
%                                     count25 = count25 + 1;
%                                     distori25{i,j}{count25,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, Letter_P)
%                                     count26 = count26 + 1;
%                                     distori26{i,j}{count26,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, RandLetter)
%                                     count27 = count27 + 1;
%                                     distori27{i,j}{count27,1} = NT{i,j}{1,run};
%                                 elseif strcmp(NT_summary2{i,j}{k,1}.contour_class, RandClosed_Hard)
%                                     count28 = count28 + 1;
%                                     distori28{i,j}{count28,1} = NT{i,j}{1,run};
%                                 else
%                                     count29 = count29 + 1;
%                                     distori29{i,j}{count29,1} = NT{i,j}{1,run};
%                                 end
%                             end
%                         end
%                     end
%                 end
%             end
% %         end
%     end
% end
% 
% save('distori1', 'distori1'); save('distori2', 'distori2'); save('distori3', 'distori3'); save('distori4', 'distori4'); save('distori5', 'distori5');
% save('distori6', 'distori6'); save('distori7', 'distori7'); save('distori8', 'distori8'); save('distori9', 'distori9'); save('distori10', 'distori10');
% save('distori11', 'distori11'); save('distori12', 'distori12'); save('distori13', 'distori13'); save('distori14', 'distori14'); 
% save('distori15', 'distori15'); save('distori16', 'distori16'); save('distori17', 'distori17'); save('distori18', 'distori18'); 
% save('distori19', 'distori19'); save('distori20', 'distori20'); save('distori21', 'distori21'); save('distori22', 'distori22'); 
% save('distori23', 'distori23'); save('distori24', 'distori24'); save('distori25', 'distori25'); save('distori26', 'distori26'); 
% save('distori27', 'distori27'); save('distori28', 'distori28'); save('distori29', 'distori29');
%% Calculating the Inducer Threshold for all contour classes

% for i = 1:29 % 29 contour types
%     if i == 15
%         continue;
%     else
%     dummy = load(['dist' num2str(i)]);
%     dummy = struct2cell(dummy);
%     for ii = 1:size(dummy{1},1)
%         for jj = 1:size(dummy{1},2)
%             count = [];
%             if isempty(dummy{1}{ii,jj}) == 1
%                 avg_thresh = NaN;
%                 Thresh = NaN;
%             else
%                 for kk = 1:length(dummy{1}{ii,jj})
%                     for mm = 1:length(dummy{1}{ii,jj}{kk,1})
%                         count = [count ; dummy{1}{ii,jj}{kk,1}(mm,1).inducers];
%                     end
%                     thresh = [];
%                     flag = 0;
%                     for ll = 1:length(count) - 1
%                         c = 0;
%                         if count(ll+1) < count(ll) && flag == 0
%                             thresh = [thresh ; count(ll)];
%                             flag = 1;
%                         end
%                         if count(ll+1) > count(ll) && flag == 1
%                             thresh = [thresh ; count(ll)];
%                             flag = 0;
%                         end
%                     end
%                     avg_thresh = mean(thresh,'omitnan');
%                     Thresh(kk,1) = avg_thresh;
%                 end
%             end
%             threshh(ii,jj) = mean(Thresh,'omitnan');
%             clear avg_thresh; clear Thresh;
%         end
%     end
%     NT_Count_thresh{i,1} = threshh;
%     clear threshh;
%     %         save(['Thresh_dist' num2str(i)], 'Count_thresh');
%     end
% end
% save('NT_Count_thresh', 'NT_Count_thresh');
%% Calculating the threshold for Orientation Jitter
% for i = 1:29 % contour types
%     dummy_ori = load(['distori' num2str(i)]);
%     dummy_ori = struct2cell(dummy_ori);
%     for ii = 1:size(dummy_ori{1},1)
%         for jj = 1:size(dummy_ori{1},2)
%             count_ori = [];
%             if isempty(dummy_ori{1}{ii,jj}) == 1
%                 avg_thresh_ori = NaN;
%                 Thresh_ori = NaN;
%             else
%                 for kk = 1:length(dummy_ori{1}{ii,jj})
%                     for mm = 1:length(dummy_ori{1}{ii,jj}{kk,1})
%                         count_ori = [count_ori ; dummy_ori{1}{ii,jj}{kk,1}(mm,1).orientationJitter];
%                     end
%                     thresh_ori = [];
%                     flag_ori = 0;
%                     for ll = 1:length(count_ori) - 1
%                         c = 0;
%                         if count_ori(ll+1) < count_ori(ll) && flag_ori == 0
%                             thresh_ori = [thresh_ori ; count_ori(ll)];
%                             flag_ori = 1;
%                         end
%                         if count_ori(ll+1) > count_ori(ll) && flag_ori == 1
%                             thresh_ori = [thresh_ori ; count_ori(ll)];
%                             flag_ori = 0;
%                         end
%                     end
%                     avg_thresh_ori = mean(thresh_ori,'omitnan');
%                     Thresh_ori(kk,1) = avg_thresh_ori;
%                 end
%             end
%             threshh_ori(ii,jj) = mean(Thresh_ori,'omitnan');
%             clear avg_thresh_ori; clear Thresh_ori;
%         end
%     end
%     NT_Ori_thresh{i,1} = threshh_ori;
%     clear threshh_ori;
%     %         save(['Thresh_dist' num2str(i)], 'Count_thresh');
% end
% save('NT_Ori_thresh', 'NT_Ori_thresh');
%% Calculating the ratio of the distractor thresholds to the Control condition (Circle_General)
% clear all; close all; clc
load('NT_Count_thresh');
load('NT_Ori_thresh');
for i = 1:length(NT_Count_thresh)
    inducer_threshold_nt(i,1) = mean(mean(NT_Count_thresh{i,1},1,'omitnan'),'omitnan');
    inducer_sd_nt(i,1) = std(mean(NT_Count_thresh{i,1},1,'omitnan'),'omitnan');
end
for i = 1:length(NT_Ori_thresh)
    jitter_threshold_nt(i,1) = mean(mean(NT_Ori_thresh{i,1},1,'omitnan'),'omitnan');
    jitter_sd_nt(i,1) = std(mean(NT_Ori_thresh{i,1},1,'omitnan'),'omitnan');
end

for j = 1:length(inducer_threshold_nt)
    inducer_threshold_final(j,1) = inducer_threshold_nt(j,1)./ inducer_threshold_nt(1,1); % easier < 1; difficult > 1
end
for k = 1:length(jitter_threshold_nt)
    jitter_threshold_final(k,1) = jitter_threshold_nt(k,1) ./ jitter_threshold_nt(1,1); % easier > 1; difficult < 1
end
y1 = -(inducer_threshold_final - 1);
y2 = (jitter_threshold_final - 1);
yy = [y1';y2'];
y3 = mean(yy,1,'omitnan');
y3_sd = std(yy,1,'omitnan');
y33 = 1:29;

[y4,idx] = sort(y3);
y33_sd = y3_sd(idx);
y33 = y33(idx);
x = (1:29)';

figure(1) % Normalized Contour Thresholds
% subplot(3,1,1)
% plot(x,inducer_threshold_final, 'b--o', 'LineWidth', 2)
% hold on;
% plot(x,jitter_threshold_final, 'r--o', 'LineWidth', 2)
% xlabel('Contour Types')
% xticks([0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30])
% ylabel('Threshold relative to Circle')
% legend('Inducers','Orientation Jitter');
% grid on

subplot(3,1,1)
plot(x,y1, 'b--o', 'LineWidth', 2)
hold on;
plot(x,y2, 'r--o', 'LineWidth', 2)
xlabel('Contour Types')
xticks([0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30])
ylabel('Normalized threhsolds')
legend('Inducers','Orientation Jitter');
grid on

subplot(3,1,2)
errorbar(x,y3,y3_sd, 'k--o', 'LineWidth', 2)
xlabel('Contour Types')
xticks([0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30])
ylabel('Normalized Average threhsolds')
grid on

subplot(3,1,3)
errorbar(x,y4,y33_sd, 'g--o', 'LineWidth', 2)
xlabel('Ordered Contour Types')
set(gca,'xtick',1:numel(idx),'xticklabel',idx)
% xticks([0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30])
ylabel('Normalized Average threhsolds')
grid on

x = (1:29)';
figure(2) % Relative C ontour Thresholds
% errorbar(x, inducer_threshold_final, inducer_sd, 'b--o', 'LineWidth', 2)
plot(x,inducer_threshold_final, '--o', 'Color', [0.4940 0.1840 0.5560], 'LineWidth', 2)
hold on;
plot(x,jitter_threshold_final, '--o', 'Color',[0 0.4470 0.7410], 'LineWidth', 2) 
xlim([1 30])
xlabel('Contour Class', 'fontsize', 14)
xticks([0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30])
ylabel('Contour Classes : Circle General', 'fontsize', 14)
title('Relative Contour Thresholds - NT', 'fontsize', 18)
legend('Inducer Threshold', 'Jitter Threshold')
grid on
yline(inducer_threshold_final(1,1),'LineWidth', 3)

figure(3) % Actual Count Threshold
errorbar(x, inducer_threshold_nt, inducer_sd_nt, '--o', 'Color', [0.4940 0.1840 0.5560], 'LineWidth', 2)
xlabel('Contour Class', 'fontsize', 14)
xticks([0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30])
ylabel('Inducer Threshold', 'fontsize', 14)
title ('Count Threshold', 'fontsize', 18)
yline(inducer_threshold_nt(1,1), 'LineWidth', 3)
grid on

figure(4)% Actual jitter Threshold
errorbar(x, jitter_threshold_nt, jitter_sd_nt, '--o', 'Color', [0 0.4470 0.7410], 'LineWidth', 2)
xlabel('Contour Class', 'fontsize', 14)
xticks([0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30])
ylabel('Jitter Threshold', 'fontsize', 14)
title ('Orientation Jitter Threshold', 'fontsize', 18)
yline(jitter_threshold_nt(1,1), 'LineWidth', 3)
grid on
%% Plotting violin distributions of participants threshold for each contour type

for i = 1:length(NT_Count_thresh)
    count_threshold{i,1} = mean(NT_Count_thresh{i,1},2,'omitnan');
    count_sd{i,1} = std(NT_Count_thresh{i,1},1,2,'omitnan');
end
count_threshold =  count_threshold(~cellfun('isempty', count_threshold));
count_threshold = count_threshold';
figure(5) % Count violins
fc = ones(1,length(count_threshold)) * 0.4;
[h,L,MX,MED] = violin(count_threshold,'facecolor',[.4 .4 .4],'edgecolor','k', 'mc','k','medc','r--'); %violin();
hold on;
for j = 1:length(count_threshold)
    x = ones(1,length(count_threshold{1,j})) * j;
    scatter(x,count_threshold{1,j},'b')
    hold on;
end
xlabel('Contour Types')
ylabel('Count Threshold')
title('Violin distributions of the Count Threshold for each Contour type - NT')

for i = 1:length(NT_Ori_thresh)
%     if i == 11
%         continue;
%     else
        OJ_threshold{i,1} = log10(mean(NT_Ori_thresh{i,1},2,'omitnan'));
        OJ_sd{i,1} = std(NT_Ori_thresh{i,1},1,2,'omitnan');
%     end
end
OJ_threshold =  OJ_threshold(~cellfun('isempty', OJ_threshold));
OJ_threshold = OJ_threshold';
figure(6) % jitter violins
fc = ones(1,length(OJ_threshold)) * 0.4;
[h,L,MX,MED] = violin(OJ_threshold,'facecolor',[.4 .4 .4],'edgecolor','k', 'mc','k','medc','r--'); %violin();
hold on;
for j = 1:length(OJ_threshold)
    x = ones(1,length(OJ_threshold{1,j})) * j;
    scatter(x,OJ_threshold{1,j},'b')
    hold on;
end
xlabel('Contour Types')
ylabel('log(OJ Threshold)')
title('Violin distributions of Jitter Thresholds for each Contour type - NT')

%% Identifying and plotting the performance of the participants in 2 halves of the 40 training sessions
clear all; close all; clc
for i = 6 %1:29 % contour types
    dummy_ori = load(['distori' num2str(i)]);
    dummy_ori = struct2cell(dummy_ori);
    for ii = 1:size(dummy_ori{1},1)
        for jj = 1:size(dummy_ori{1},2)
            count_ori = [];
            if isempty(dummy_ori{1}{ii,jj}) == 1
                avg_thresh_ori = NaN;
                Thresh_ori = NaN;
            else
                for kk = 1:length(dummy_ori{1}{ii,jj})
                    for mm = 1:length(dummy_ori{1}{ii,jj}{kk,1})
                        count_ori = [count_ori ; dummy_ori{1}{ii,jj}{kk,1}(mm,1).orientationJitter];
                    end
                    thresh_ori = [];
                    flag_ori = 0;
                    for ll = 1:length(count_ori) - 1
                        c = 0;
                        if count_ori(ll+1) < count_ori(ll) && flag_ori == 0
                            thresh_ori = [thresh_ori ; count_ori(ll)];
                            flag_ori = 1;
                        end
                        if count_ori(ll+1) > count_ori(ll) && flag_ori == 1
                            thresh_ori = [thresh_ori ; count_ori(ll)];
                            flag_ori = 0;
                        end
                    end
                    avg_thresh_ori = mean(thresh_ori,'omitnan');
                    Thresh_ori(kk,1) = avg_thresh_ori;
                end
            end
            threshh_ori(ii,jj) = mean(Thresh_ori,'omitnan');
            clear avg_thresh_ori; clear Thresh_ori;
        end
    end
    NT_Ori_thresh{i,1} = threshh_ori;
    clear threshh;
    %         save(['Thresh_dist' num2str(i)], 'Count_thresh');
end
save('Ori_thresh', 'Ori_thresh');



figure(7) % session halves violins for jitter
for i = 1:length(NT_Count_thresh)
    count_threshold{i,1} = mean(NT_Count_thresh{i,1},2,'omitnan');
    count_sd{i,1} = std(NT_Count_thresh{i,1},1,2,'omitnan');
end
count_threshold =  count_threshold(~cellfun('isempty', count_threshold));
count_threshold = count_threshold';
figure(5) % Count violins
fc = ones(1,length(count_threshold)) * 0.4;
[h,L,MX,MED] = violin(count_threshold,'facecolor',[.4 .4 .4],'edgecolor','k', 'mc','k','medc','r--'); %violin();
hold on;
for j = 1:length(count_threshold)
    x = ones(1,length(count_threshold{1,j})) * j;
    scatter(x,count_threshold{1,j},'b')
    hold on;
end
xlabel('Contour Types')
ylabel('Count Threshold')
title('Violin distributions of the Count Threshold for each Contour type')