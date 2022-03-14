%% Contour Training data Analysis - Distractor information

clear all
close all
clc

%% Looping through every file in the directory - Individual and Summary

files = dir('*.json');
count = 1;
part_cmp = 'STS1005';
count_odd = 0;
for i = 1:length(files)
    [~,names] = fileparts(files(i).name);
    cmp_name = names(end-9:end);
    log_name = 'ContourLog';
    part_name = names(1:7);
    ses_name = names(10:11);
    block_name = names(15);
    run_name = names(18:19);
    ses = str2double(regexp(ses_name,'\d*','match'));
    run = str2double(regexp(run_name,'\d*','match'));
    block = str2double(regexp(block_name,'\d*','match'));
    if sum(part_name ~= part_cmp) > 0
        count = count + 1;
        part_cmp = part_name;
        count_odd = 0;
        if cmp_name == log_name
            if block == 0
                count_odd = ses + 1;
                fname = (files(i).name);
                val = jsondecode(fileread(fname));
                NT{count,ses+count_odd}{1,run+1} = val.data;
            else
                fname = (files(i).name);
                val = jsondecode(fileread(fname));
                NT{count,(ses+1)*2}{1,run+1} = val.data;
            end
        end
    else
        if cmp_name == log_name
            if block == 0
                count_odd = ses + 1;
                fname = (files(i).name);
                val = jsondecode(fileread(fname));
                NT{count,ses+count_odd}{1,run+1} = val.data;
            else
                fname = (files(i).name);
                val = jsondecode(fileread(fname));
                NT{count,(ses+1)*2}{1,run+1} = val.data;
            end
        end
    end
end

save('NT_data', 'NT')

files = dir('*.json');
count = 1;
part_cmp = 'STS1005';
for i = 1:length(files)
    [~,names] = fileparts(files(i).name);
    cmp_name = names(end-6:end);
    log_name = 'Summary';
    part_name = names(1:7);
    ses_name = names(10:11);
    ses = str2double(regexp(ses_name,'\d*','match'));
    if sum(part_name ~= part_cmp) > 0
        count = count + 1;
        part_cmp = part_name;
        if cmp_name == log_name
            fname = (files(i).name);
            val = jsondecode(fileread(fname));
            NT{count,ses+1}{1,run+1} = val.data;
        end
    else
            if (cmp_name == log_name)
                fname = (files(i).name);
                val = jsondecode(fileread(fname));
                NT_summary{count,ses+1} = val.data;
            end
    end
end

% Organising the Summary file to account for 20 training sessions

Contour = 'Contour';
for i = 1:size(NT_summary,1)
    for j = 1:size(NT_summary,2)
        if i == 13 && j == 8
            continue;
        else
            if ~isempty(NT_summary{i,j})
                count = 0;
                for k = 1:length(NT_summary{i,j})                    
                    fields = fieldnames(NT_summary{i,j}{k,1});
                    if contains(NT_summary{i,j}{k,1}.game_type, 'Contour')
                        if NT_summary{i,j}{k,1}.element == 0
                            dummy0{i,j}{k,1} = NT_summary{i,j}{k,1};
                        else
                            dummy2{i,j}{k,1} = NT_summary{i,j}{k,1};
                        end
                    end
                end
            end
        end
    end
end

% Removing empty cells from the dummy2 matrices
for i = 1:size(NT_summary,1)
    for j = 1:size(NT_summary,2)
        if ~isempty(dummy2{i,j})
            bla = dummy2{i,j};
            bla = bla(~cellfun('isempty', bla));
            dummy2{i,j} = bla;
        end
    end
end
odd = 1:20;
even = 1:20;
count1 = 0:0.5:9;
for i = 1:size(dummy0,1)
    for j = 1:20 %size(dummy0,2)
        if mod(j,2) ~= 0
            NT_summary2{i,odd(j)} = dummy0{i,j-count1(j)};  
        else
            NT_summary2{i,even(j)} = dummy2{i,j/2};
        end
    end
end

NT_summary = NT_summary2;
save('NT_summary','NT_summary');

%% Isolating data contour class - wise

Contour = 'Contour'; % Task name
contour_class = 'contour_class'; % Class of task name
OrientationJitter = 'OrientationJitter'; % Parameter 1
InducerNumber = 'Count'; % Parameter 2

Circle_General = "Circle_General"; % Task coded name for Circle shape
Line_V = "Line_V"; % Task coded name for Line shape 1
Line_H = "Line_H"; % Task coded name for Line shape 2
Ellipse_V = "Ellipse_V_Fixed"; % Task coded name for Ellipse shape 1
Ellipse_H = "Ellipse_H_Fixed"; % Task coded name for Ellipse shape 2
Ellipse_R = "Ellipse_R_Fixed"; % Task coded name for Ellipse shape 3
Spiral_General = "Spiral_General"; % Task coded name for Spiral shape
Blob_1 = "Blob_1"; % Task coded name for Blob shape 1
Blob_2 = "Blob_2"; % Task coded name for Blob shape 2
Blob_3 = "Blob_3"; % Task coded name for Blob shape 3
Squiggle_V = "Squiggle_V_Locked"; % Task coded name for Squiggle shape 1
Squiggle_H = "Squiggle_H_Locked"; % Task coded name for Squiggle shape 2
Letter_B = "Letter_B"; % Task coded name for Letter shape 1
Letter_D = "Letter_D"; % Task coded name for Letter shape 2
Letter_P = "Letter_P"; % Task coded name for Letter shape 3

for i = 1:size(NT,1) % For each participant
    for j = 1:size(NT,2) % For each session
        % Setting counters for each Family
        count1 = 0;
        count2 = 0;
        count3 = 0;
        count4 = 0;
        count5 = 0;
        count6 = 0;
        count7 = 0;
        if ~isempty(NT_summary{i,j})
            for k = 1:length(NT_summary{i,j})
                if contains(NT_summary{i,j}{k,1}.game_type, Contour)
                    if contains(NT_summary{i,j}{k,1}.contour_parameter, OrientationJitter)
                        run = NT_summary{i,j}{k,1}.run + 1;
                        if strcmp(NT_summary{i,j}{k,1}.contour_class, Circle_General) % Comparing strings within the summary file to isolate runs when Circle shape was presented
                            count1 = count1 + 1;
                            Circle{i,j}{count1,1} = NT{i,j}{1,run};
                        elseif strcmp(NT_summary{i,j}{k,1}.contour_class, Line_V) || strcmp(NT_summary{i,j}{k,1}.contour_class, Line_H)
                            count2 = count2 + 1;
                            Lines{i,j}{count2,1} = NT{i,j}{1,run};
                        elseif strcmp(NT_summary{i,j}{k,1}.contour_class, Ellipse_V) || strcmp(NT_summary{i,j}{k,1}.contour_class, Ellipse_H) || strcmp(NT_summary{i,j}{k,1}.contour_class, Ellipse_R)
                            count3 = count3 + 1;
                            Ellipses{i,j}{count3,1} = NT{i,j}{1,run};
                        elseif strcmp(NT_summary{i,j}{k,1}.contour_class, Spiral_General)
                            count4 = count4 + 1;
                            Spiral{i,j}{count4,1} = NT{i,j}{1,run};
                        elseif strcmp(NT_summary{i,j}{k,1}.contour_class, Blob_1) || strcmp(NT_summary{i,j}{k,1}.contour_class, Blob_2) || strcmp(NT_summary{i,j}{k,1}.contour_class, Blob_3)
                            count5 = count5 + 1;
                            Blobs{i,j}{count5,1} = NT{i,j}{1,run};
                        elseif strcmp(NT_summary{i,j}{k,1}.contour_class, Squiggle_V) || strcmp(NT_summary{i,j}{k,1}.contour_class, Squiggle_H)
                            count6 = count6 + 1;
                            Squiggles{i,j}{count6,1} = NT{i,j}{1,run};
                        else
                            if strcmp(NT_summary{i,j}{k,1}.contour_class, Letter_B) || strcmp(NT_summary{i,j}{k,1}.contour_class, Letter_D) || strcmp(NT_summary{i,j}{k,1}.contour_class, Letter_P)
                                count7 = count7 + 1;
                                Letters{i,j}{count7,1} = NT{i,j}{1,run};
                            end
                        end
                    end
                end
            end
        end
    end
end

save ('Circle','Circle'); save ('Lines','Lines'); save ('Ellipses','Ellipses'); 
save ('Spiral','Spiral'); save ('Blobs','Blobs'); save ('Squiggles','Squiggles');
save ('Letters','Letters');

%% Isolating Orientation Jitter Thresholds for each shape

clear all

% Circle 
load('Circle.mat')
Circle_OJ_thresh = isolate_threshold(Circle);
save('Circle_OJ_thresh','Circle_OJ_thresh');

% Lines 
load('Lines.mat')
Lines_OJ_thresh = isolate_threshold(Lines);
save('Lines_OJ_thresh','Lines_OJ_thresh');

% Ellipses 
load('Ellipses.mat')
Ellipses_OJ_thresh = isolate_threshold(Ellipses);
save('Ellipses_OJ_thresh','Ellipses_OJ_thresh');

% Spiral 
load('Spiral.mat')
Spiral_OJ_thresh = isolate_threshold(Spiral);
save('Spiral_OJ_thresh','Spiral_OJ_thresh');

% Blobs 
load('Blobs.mat')
Blobs_OJ_thresh = isolate_threshold(Blobs);
save('Blobs_OJ_thresh','Blobs_OJ_thresh');

% Squiggles
load('Squiggles.mat')
Squiggles_OJ_thresh = isolate_threshold(Squiggles);
save('Squiggles_OJ_thresh','Squiggles_OJ_thresh');

% Letters
load('Letters.mat')
Letters_OJ_thresh = isolate_threshold(Letters);
save('Letters_OJ_thresh','Letters_OJ_thresh');

%% Calculating the average performance for a Contour Shape - Orientation Jitter

clear all

% Circle

load('Circle_OJ_thresh.mat');
Circle_OJ_pmeans = nanmean(Circle_OJ_thresh,2); %participant means over 40 sessions
Circle_OJ_thresh_final = nanmean(Circle_OJ_pmeans);
% Within subject SE
Circle_win_se_val = Circle_OJ_pmeans - Circle_OJ_thresh_final;
Circle_win_sd = nanstd(Circle_win_se_val);
Circle_OJ_win_se = Circle_win_sd./(size(Circle_OJ_pmeans(~isnan(Circle_OJ_pmeans)),1) ^ (1/2));
Circle_NT = [Circle_OJ_pmeans; Circle_OJ_thresh_final;Circle_OJ_win_se];
save('/Users/samyuktajayakumar/Sightseeing Dropbox/Samyukta Jayakumar/Mac/Desktop/Winter_2022_Course_Materials/PSYC 259/Final Project/PSYC-259-Final-Project/Codes/SP/Circle_NT','Circle_NT');

% Lines

load('Lines_OJ_thresh.mat');
Lines_OJ_pmeans = nanmean(Lines_OJ_thresh,2); %participant means over 40 sessions
Lines_OJ_thresh_final = nanmean(Lines_OJ_pmeans);
% Within subject SE
Lines_win_se_val = Lines_OJ_pmeans - Lines_OJ_thresh_final;
Lines_win_sd = nanstd(Lines_win_se_val);
Lines_OJ_win_se = Lines_win_sd./(size(Lines_OJ_pmeans(~isnan(Lines_OJ_pmeans)),1) ^ (1/2));
Lines_NT = [Lines_OJ_pmeans; Lines_OJ_thresh_final;Lines_OJ_win_se];
save('/Users/samyuktajayakumar/Sightseeing Dropbox/Samyukta Jayakumar/Mac/Desktop/Winter_2022_Course_Materials/PSYC 259/Final Project/PSYC-259-Final-Project/Codes/SP/Lines_NT','Lines_NT');

% Ellipses

load('Ellipses_OJ_thresh.mat'); 
Ellipses_OJ_pmeans = nanmean(Ellipses_OJ_thresh,2); %participant means over 40 sessions
Ellipses_OJ_thresh_final = nanmean(Ellipses_OJ_pmeans);
% Within subject SE
Ellipses_win_se_val = Ellipses_OJ_pmeans - Ellipses_OJ_thresh_final;
Ellipses_win_sd = nanstd(Ellipses_win_se_val);
Ellipses_OJ_win_se = Ellipses_win_sd./(size(Ellipses_OJ_pmeans(~isnan(Ellipses_OJ_pmeans)),1) ^ (1/2));
Ellipses_NT = [Ellipses_OJ_pmeans; Ellipses_OJ_thresh_final;Ellipses_OJ_win_se];
save('/Users/samyuktajayakumar/Sightseeing Dropbox/Samyukta Jayakumar/Mac/Desktop/Winter_2022_Course_Materials/PSYC 259/Final Project/PSYC-259-Final-Project/Codes/SP/Ellipses_NT','Ellipses_NT');

% Spiral

load('Spiral_OJ_thresh.mat');
Spiral_OJ_pmeans = nanmean(Spiral_OJ_thresh,2); %participant means over 40 sessions
Spiral_OJ_thresh_final = nanmean(Spiral_OJ_pmeans);
% Within subject SE
Spiral_win_se_val = Spiral_OJ_pmeans - Spiral_OJ_thresh_final;
Spiral_win_sd = nanstd(Spiral_win_se_val);
Spiral_OJ_win_se = Spiral_win_sd./(size(Spiral_OJ_pmeans(~isnan(Spiral_OJ_pmeans)),1) ^ (1/2));
Spiral_NT = [Spiral_OJ_pmeans; Spiral_OJ_thresh_final;Spiral_OJ_win_se];
save('/Users/samyuktajayakumar/Sightseeing Dropbox/Samyukta Jayakumar/Mac/Desktop/Winter_2022_Course_Materials/PSYC 259/Final Project/PSYC-259-Final-Project/Codes/SP/Spiral_NT','Spiral_NT');

% Blobs

load('Blobs_OJ_thresh.mat');
Blobs_OJ_pmeans = nanmean(Blobs_OJ_thresh,2); %participant means over 40 sessions
Blobs_OJ_thresh_final = nanmean(Blobs_OJ_pmeans);
% Within subject SE
Blobs_win_se_val = Blobs_OJ_pmeans - Blobs_OJ_thresh_final;
Blobs_win_sd = nanstd(Blobs_win_se_val);
Blobs_OJ_win_se = Blobs_win_sd./(size(Blobs_OJ_pmeans(~isnan(Blobs_OJ_pmeans)),1) ^ (1/2));
Blobs_NT = [Blobs_OJ_pmeans; Blobs_OJ_thresh_final;Blobs_OJ_win_se];
save('/Users/samyuktajayakumar/Sightseeing Dropbox/Samyukta Jayakumar/Mac/Desktop/Winter_2022_Course_Materials/PSYC 259/Final Project/PSYC-259-Final-Project/Codes/SP/Blobs_NT','Blobs_NT');

% Squiggles

load('Squiggles_OJ_thresh.mat'); 
Squiggles_OJ_pmeans = nanmean(Squiggles_OJ_thresh,2); %participant means over 40 sessions
Squiggles_OJ_thresh_final = nanmean(Squiggles_OJ_pmeans);
% Within subject SE
Squiggles_win_se_val = Squiggles_OJ_pmeans - Squiggles_OJ_thresh_final;
Squiggles_win_sd = nanstd(Squiggles_win_se_val);
Squiggles_OJ_win_se = Squiggles_win_sd./(size(Squiggles_OJ_pmeans(~isnan(Squiggles_OJ_pmeans)),1) ^ (1/2));
Squiggles_NT = [Squiggles_OJ_pmeans; Squiggles_OJ_thresh_final;Squiggles_OJ_win_se];
save('/Users/samyuktajayakumar/Sightseeing Dropbox/Samyukta Jayakumar/Mac/Desktop/Winter_2022_Course_Materials/PSYC 259/Final Project/PSYC-259-Final-Project/Codes/SP/Squiggles_NT','Squiggles_NT');

% Letters

load('Letters_OJ_thresh.mat');
Letters_OJ_pmeans = nanmean(Letters_OJ_thresh,2); %participant means over 40 sessions
Letters_OJ_thresh_final = nanmean(Letters_OJ_pmeans);
% Within subject SE
Letters_win_se_val = Letters_OJ_pmeans - Letters_OJ_thresh_final;
Letters_win_sd = nanstd(Letters_win_se_val);
Letters_OJ_win_se = Letters_win_sd./(size(Letters_OJ_pmeans(~isnan(Letters_OJ_pmeans)),1) ^ (1/2));
Letters_NT = [Letters_OJ_pmeans; Letters_OJ_thresh_final;Letters_OJ_win_se];
save('/Users/samyuktajayakumar/Sightseeing Dropbox/Samyukta Jayakumar/Mac/Desktop/Winter_2022_Course_Materials/PSYC 259/Final Project/PSYC-259-Final-Project/Codes/SP/Letters_NT','Letters_NT');