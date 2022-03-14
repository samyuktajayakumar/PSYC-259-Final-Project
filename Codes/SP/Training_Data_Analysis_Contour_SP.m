%% Analysing Training Data - Contour Data
clear all
close all
clc

%% Looping through every file in the directory - Individual and Summary

files = dir('*.json'); % Identifies all .json files from the directory
count = 1;
part_cmp = 'CA1005A'; % Reference participant # to begin the loop
for i = 1:length(files)
    [~,names] = fileparts(files(i).name);
    cmp_name = names(end-9:end);
    log_name = 'ContourLog'; % Isolates the log file name
    part_name = names(1:7);  % Isolates the participant name
    ses_name = names(10:11); % Isolates the session #
    run_name = names(18:19); % Isolates the run #
    ses = str2double(regexp(ses_name,'\d*','match'));
    run = str2double(regexp(run_name,'\d*','match'));
    if sum(part_name ~= part_cmp) > 0 % Comparing strings
        count = count + 1;
        part_cmp = part_name;
        if cmp_name == log_name
            fname = (files(i).name);
            val = jsondecode(fileread(fname));
            SP{count,ses+1}{1,run+1} = val.data; % Enters participants as rows and sessions as columns in a cell format
        end
    else
        if cmp_name == log_name
            fname = (files(i).name);
            val = jsondecode(fileread(fname));
            SP{count,ses+1}{1,run+1} = val.data;
        end
    end
end
save('SP_data', 'SP')

% Summary Files

files = dir('*.json');
count = 1;
part_cmp = 'CA1005A';
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
            SP{count,ses+1}{1,run+1} = val.data;
        end
    else
            if (cmp_name == log_name)
                fname = (files(i).name);
                val = jsondecode(fileread(fname));
                SP_summary{count,ses+1} = val.data;
            end
    end
end
save('SP_summary', 'SP_summary')


%% Isolating data for Families of Contour shapes

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

for i = 1:size(SP,1) % For each participant
    for j = 1:size(SP,2) % For each session
        % Setting counters for each Family
        count1 = 0;
        count2 = 0;
        count3 = 0;
        count4 = 0;
        count5 = 0;
        count6 = 0;
        count7 = 0;
        if ~isempty(SP_summary{i,j})
            for k = 1:length(SP_summary{i,j})
                if contains(SP_summary{i,j}{k,1}.game_type, Contour)
                    if contains(SP_summary{i,j}{k,1}.contour_parameter, OrientationJitter)
                        run = SP_summary{i,j}{k,1}.run + 1;
                        if strcmp(SP_summary{i,j}{k,1}.contour_class, Circle_General) % Comparing strings within the summary file to isolate runs when Circle shape was presented
                            count1 = count1 + 1;
                            Circle{i,j}{count1,1} = SP{i,j}{1,run};
                        elseif strcmp(SP_summary{i,j}{k,1}.contour_class, Line_V) || strcmp(SP_summary{i,j}{k,1}.contour_class, Line_H)
                            count2 = count2 + 1;
                            Lines{i,j}{count2,1} = SP{i,j}{1,run};
                        elseif strcmp(SP_summary{i,j}{k,1}.contour_class, Ellipse_V) || strcmp(SP_summary{i,j}{k,1}.contour_class, Ellipse_H) || strcmp(SP_summary{i,j}{k,1}.contour_class, Ellipse_R)
                            count3 = count3 + 1;
                            Ellipses{i,j}{count3,1} = SP{i,j}{1,run};
                        elseif strcmp(SP_summary{i,j}{k,1}.contour_class, Spiral_General)
                            count4 = count4 + 1;
                            Spiral{i,j}{count4,1} = SP{i,j}{1,run};
                        elseif strcmp(SP_summary{i,j}{k,1}.contour_class, Blob_1) || strcmp(SP_summary{i,j}{k,1}.contour_class, Blob_2) || strcmp(SP_summary{i,j}{k,1}.contour_class, Blob_3)
                            count5 = count5 + 1;
                            Blobs{i,j}{count5,1} = SP{i,j}{1,run};
                        elseif strcmp(SP_summary{i,j}{k,1}.contour_class, Squiggle_V) || strcmp(SP_summary{i,j}{k,1}.contour_class, Squiggle_H)
                            count6 = count6 + 1;
                            Squiggles{i,j}{count6,1} = SP{i,j}{1,run};
                        else
                            if strcmp(SP_summary{i,j}{k,1}.contour_class, Letter_B) || strcmp(SP_summary{i,j}{k,1}.contour_class, Letter_D) || strcmp(SP_summary{i,j}{k,1}.contour_class, Letter_P)
                                count7 = count7 + 1;
                                Letters{i,j}{count7,1} = SP{i,j}{1,run};
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
save ('Letters','Letters')

%% Isolating Orientation Jitter Thresholds for each shape

% Circle 
clear all
load('Circle.mat')

for ii = 1:size(Circle,1)
    for jj = 1:size(Circle,2)
        if isempty(Circle{ii,jj}) == 1
            avg_thresh_ori = NaN;
            Thresh_ori = NaN;
        else
            for kk = 1:length(Circle{ii,jj})
                count_ori = [];
                for mm = 4:length(Circle{ii,jj}{kk,1})                   
                    count_ori = [count_ori ; Circle{ii,jj}{kk,1}(mm,1).orientationJitter];
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
                clear count_ori
            end
        end
        Circle_OJ_thresh(ii,jj) = mean(Thresh_ori,'omitnan');
        clear avg_thresh_ori; clear Thresh_ori;
    end
end

save('Circle_OJ_thresh','Circle_OJ_thresh');
clear all

% Lines 
clear all
load('Lines.mat')

for ii = 1:size(Lines,1)
    for jj = 1:size(Lines,2)
        if isempty(Lines{ii,jj}) == 1
            avg_thresh_ori = NaN;
            Thresh_ori = NaN;
        else
            for kk = 1:length(Lines{ii,jj})
                count_ori = [];
                for mm = 4:length(Lines{ii,jj}{kk,1})                   
                    count_ori = [count_ori ; Lines{ii,jj}{kk,1}(mm,1).orientationJitter];
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
                clear count_ori
            end
        end
        Lines_OJ_thresh(ii,jj) = mean(Thresh_ori,'omitnan');
        clear avg_thresh_ori; clear Thresh_ori;
    end
end

save('Lines_OJ_thresh','Lines_OJ_thresh');
clear all

% Ellipses 
clear all
load('Ellipses.mat')

for ii = 1:size(Ellipses,1)
    for jj = 1:size(Ellipses,2)
        if isempty(Ellipses{ii,jj}) == 1
            avg_thresh_ori = NaN;
            Thresh_ori = NaN;
        else
            for kk = 1:length(Ellipses{ii,jj})
                count_ori = [];
                for mm = 4:length(Ellipses{ii,jj}{kk,1})                   
                    count_ori = [count_ori ; Ellipses{ii,jj}{kk,1}(mm,1).orientationJitter];
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
                clear count_ori
            end
        end
        Ellipses_OJ_thresh(ii,jj) = mean(Thresh_ori,'omitnan');
        clear avg_thresh_ori; clear Thresh_ori;
    end
end

save('Ellipses_OJ_thresh','Ellipses_OJ_thresh');
clear all

% Spiral 
clear all
load('Spiral.mat')

for ii = 1:size(Spiral,1)
    for jj = 1:size(Spiral,2)
        if isempty(Spiral{ii,jj}) == 1
            avg_thresh_ori = NaN;
            Thresh_ori = NaN;
        else
            for kk = 1:length(Spiral{ii,jj})
                count_ori = [];
                for mm = 4:length(Spiral{ii,jj}{kk,1})                   
                    count_ori = [count_ori ; Spiral{ii,jj}{kk,1}(mm,1).orientationJitter];
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
                clear count_ori
            end
        end
        Spiral_OJ_thresh(ii,jj) = mean(Thresh_ori,'omitnan');
        clear avg_thresh_ori; clear Thresh_ori;
    end
end

save('Spiral_OJ_thresh','Spiral_OJ_thresh');
clear all

% Blobs 
clear all
load('Blobs.mat')

for ii = 1:size(Blobs,1)
    for jj = 1:size(Blobs,2)
        if isempty(Blobs{ii,jj}) == 1
            avg_thresh_ori = NaN;
            Thresh_ori = NaN;
        else
            for kk = 1:length(Blobs{ii,jj})
                count_ori = [];
                for mm = 4:length(Blobs{ii,jj}{kk,1})                   
                    count_ori = [count_ori ; Blobs{ii,jj}{kk,1}(mm,1).orientationJitter];
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
                clear count_ori
            end
        end
        Blobs_OJ_thresh(ii,jj) = mean(Thresh_ori,'omitnan');
        clear avg_thresh_ori; clear Thresh_ori;
    end
end

save('Blobs_OJ_thresh','Blobs_OJ_thresh');
clear all

% Squiggles
clear all
load('Squiggles.mat')

for ii = 1:size(Squiggles,1)
    for jj = 1:size(Squiggles,2)
        if isempty(Squiggles{ii,jj}) == 1
            avg_thresh_ori = NaN;
            Thresh_ori = NaN;
        else
            for kk = 1:length(Squiggles{ii,jj})
                count_ori = [];
                for mm = 4:length(Squiggles{ii,jj}{kk,1})                   
                    count_ori = [count_ori ; Squiggles{ii,jj}{kk,1}(mm,1).orientationJitter];
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
                clear count_ori
            end
        end
        Squiggles_OJ_thresh(ii,jj) = mean(Thresh_ori,'omitnan');
        clear avg_thresh_ori; clear Thresh_ori;
    end
end

save('Squiggles_OJ_thresh','Squiggles_OJ_thresh');
clear all

% Letters
clear all
load('Letters.mat')

for ii = 1:size(Letters,1)
    for jj = 1:size(Letters,2)
        if isempty(Letters{ii,jj}) == 1
            avg_thresh_ori = NaN;
            Thresh_ori = NaN;
        else
            for kk = 1:length(Letters{ii,jj})
                count_ori = [];
                for mm = 4:length(Letters{ii,jj}{kk,1})                   
                    count_ori = [count_ori ; Letters{ii,jj}{kk,1}(mm,1).orientationJitter];
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
                clear count_ori
            end
        end
        Letters_OJ_thresh(ii,jj) = mean(Thresh_ori,'omitnan');
        clear avg_thresh_ori; clear Thresh_ori;
    end
end

save('Letters_OJ_thresh','Letters_OJ_thresh');
clear all

%% Calculating the average performance for a Contour Shape - Orientation Jitter

% Circle

load('Circle_OJ_thresh.mat');
Circle_OJ_pmeans = nanmean(Circle_OJ_thresh,2); %participant means over 40 sessions
Circle_OJ_thresh_final = nanmean(Circle_OJ_pmeans);
% Within subject SE
Circle_win_se_val = Circle_OJ_pmeans - Circle_OJ_thresh_final;
Circle_win_sd = nanstd(Circle_win_se_val);
Circle_OJ_win_se = Circle_win_sd./(size(Circle_OJ_pmeans(~isnan(Circle_OJ_pmeans)),1) ^ (1/2));
Circle_SP = [Circle_OJ_pmeans; Circle_OJ_thresh_final;Circle_OJ_win_se];

% Lines

load('Lines_OJ_thresh.mat');
Lines_OJ_pmeans = nanmean(Lines_OJ_thresh,2); %participant means over 40 sessions
Lines_OJ_thresh_final = nanmean(Lines_OJ_pmeans);
% Within subject SE
Lines_win_se_val = Lines_OJ_pmeans - Lines_OJ_thresh_final;
Lines_win_sd = nanstd(Lines_win_se_val);
Lines_OJ_win_se = Lines_win_sd./(size(Lines_OJ_pmeans(~isnan(Lines_OJ_pmeans)),1) ^ (1/2));
Lines_SP = [Lines_OJ_pmeans; Lines_OJ_thresh_final;Lines_OJ_win_se];

% Ellipses

load('Ellipses_OJ_thresh.mat'); 
Ellipses_OJ_pmeans = nanmean(Ellipses_OJ_thresh,2); %participant means over 40 sessions
Ellipses_OJ_thresh_final = nanmean(Ellipses_OJ_pmeans);
% Within subject SE
Ellipses_win_se_val = Ellipses_OJ_pmeans - Ellipses_OJ_thresh_final;
Ellipses_win_sd = nanstd(Ellipses_win_se_val);
Ellipses_OJ_win_se = Ellipses_win_sd./(size(Ellipses_OJ_pmeans(~isnan(Ellipses_OJ_pmeans)),1) ^ (1/2));
Ellipses_SP = [Ellipses_OJ_pmeans; Ellipses_OJ_thresh_final;Ellipses_OJ_win_se];

% Spiral

load('Spiral_OJ_thresh.mat');
Spiral_OJ_pmeans = nanmean(Spiral_OJ_thresh,2); %participant means over 40 sessions
Spiral_OJ_thresh_final = nanmean(Spiral_OJ_pmeans);
% Within subject SE
Spiral_win_se_val = Spiral_OJ_pmeans - Spiral_OJ_thresh_final;
Spiral_win_sd = nanstd(Spiral_win_se_val);
Spiral_OJ_win_se = Spiral_win_sd./(size(Spiral_OJ_pmeans(~isnan(Spiral_OJ_pmeans)),1) ^ (1/2));
Spiral_SP = [Spiral_OJ_pmeans; Spiral_OJ_thresh_final;Spiral_OJ_win_se];

% Blobs

load('Blobs_OJ_thresh.mat');
Blobs_OJ_pmeans = nanmean(Blobs_OJ_thresh,2); %participant means over 40 sessions
Blobs_OJ_thresh_final = nanmean(Blobs_OJ_pmeans);
% Within subject SE
Blobs_win_se_val = Blobs_OJ_pmeans - Blobs_OJ_thresh_final;
Blobs_win_sd = nanstd(Blobs_win_se_val);
Blobs_OJ_win_se = Blobs_win_sd./(size(Blobs_OJ_pmeans(~isnan(Blobs_OJ_pmeans)),1) ^ (1/2));
Blobs_SP = [Blobs_OJ_pmeans; Blobs_OJ_thresh_final;Blobs_OJ_win_se];

% Squiggles

load('Squiggles_OJ_thresh.mat'); 
Squiggles_OJ_pmeans = nanmean(Squiggles_OJ_thresh,2); %participant means over 40 sessions
Squiggles_OJ_thresh_final = nanmean(Squiggles_OJ_pmeans);
% Within subject SE
Squiggles_win_se_val = Squiggles_OJ_pmeans - Squiggles_OJ_thresh_final;
Squiggles_win_sd = nanstd(Squiggles_win_se_val);
Squiggles_OJ_win_se = Squiggles_win_sd./(size(Squiggles_OJ_pmeans(~isnan(Squiggles_OJ_pmeans)),1) ^ (1/2));
Squiggles_SP = [Squiggles_OJ_pmeans; Squiggles_OJ_thresh_final;Squiggles_OJ_win_se];

% Letters

load('Letters_OJ_thresh.mat');
Letters_OJ_pmeans = nanmean(Letters_OJ_thresh,2); %participant means over 40 sessions
Letters_OJ_thresh_final = nanmean(Letters_OJ_pmeans);
% Within subject SE
Letters_win_se_val = Letters_OJ_pmeans - Letters_OJ_thresh_final;
Letters_win_sd = nanstd(Letters_win_se_val);
Letters_OJ_win_se = Letters_win_sd./(size(Letters_OJ_pmeans(~isnan(Letters_OJ_pmeans)),1) ^ (1/2));
Letters_SP = [Letters_OJ_pmeans; Letters_OJ_thresh_final;Letters_OJ_win_se];

%% Creating .csv files for OJ thresholds for SP
load('Circle_NT.mat');load('Lines_NT.mat');load('Ellipses_NT.mat');load('Spiral_NT.mat');
load('Blobs_NT.mat');load('Squiggles_NT.mat');load('Letters_NT.mat');

Shapes = ["Circle";"Lines";"Ellipses";"Spiral";"Blobs";"Squiggles";"Letters";...
    "Circle";"Lines";"Ellipses";"Spiral";"Blobs";"Squiggles";"Letters"];

Mean = [Circle_SP(4,1);Lines_SP(4,1);Ellipses_SP(4,1);Spiral_SP(4,1)...
    ;Blobs_SP(4,1);Squiggles_SP(4,1);Letters_SP(4,1);...
    Circle_NT(4,1);Lines_NT(4,1);Ellipses_NT(4,1);Spiral_NT(4,1)...
    ;Blobs_NT(4,1);Squiggles_NT(4,1);Letters_NT(4,1)];

SE = [Circle_SP(5,1);Lines_SP(5,1);Ellipses_SP(5,1);Spiral_SP(5,1)...
    ;Blobs_SP(5,1);Squiggles_SP(5,1);Letters_SP(5,1);...
    Circle_NT(5,1);Lines_NT(5,1);Ellipses_NT(5,1);Spiral_NT(5,1)...
    ;Blobs_NT(5,1);Squiggles_NT(5,1);Letters_NT(5,1)];

Group = ["SP";"SP";"SP";"SP";"SP";"SP";"SP";"NT";"NT";"NT";"NT";"NT";"NT";"NT"];
OJ = table(Group,Shapes,Mean,SE);
writetable(OJ,'OJ.csv');