%% Analysing Training Data - Contour Data
clear all
close all
clc

%% Converting .json to matlab readable format and isolating data for all SF's
% Picking people with complete training session data for contrast task
part = [1005, 1018, 1028, 1005, 1018, 1002, 1012, 1016, 1002, 1016, 1017]; % CA participants with all 40 training summary files, no combined session summaries
% part = [1005, 1006, 1018, 1019, 1028, 1005, 1006, 1018, 1019, 1020, 1002, 1012, 1014, 1016, 1017, 1023, 1002, 1012, 1016, 1017]; % CA participants with all 40 training summary files, no combined session summaries
for p = 1:length(part)
    for i = 0:39
        for j = 0:1
            if  p < 4
                if i < 10
                    fname = (['CA' num2str(part(p)) 'A_00' num2str(i) '_000_00' num2str(j) '_ContourLog.json']);
                    val = jsondecode(fileread(fname));
                    Data_SP_40{p}{i+1,j+1} = val.data;
                else
                    fname = (['CA' num2str(part(p)) 'A_0' num2str(i) '_000_00' num2str(j) '_ContourLog.json']);
                    val = jsondecode(fileread(fname));
                    Data_SP_40{p}{i+1,j+1} = val.data;
                end
            else if p == 4
                    if i < 10
                        fname = (['Na' num2str(part(p)) 'A_00' num2str(i) '_000_00' num2str(j) '_ContourLog.json']);
                        val = jsondecode(fileread(fname));
                        Data_SP_40{p}{i+1,j+1} = val.data;
                    else
                        fname = (['Na' num2str(part(p)) 'A_0' num2str(i) '_000_00' num2str(j) '_ContourLog.json']);
                        val = jsondecode(fileread(fname));
                        Data_SP_40{p}{i+1,j+1} = val.data;
                    end
                else if p == 5
                        if i < 10
                            fname = (['NA' num2str(part(p)) 'A_00' num2str(i) '_000_00' num2str(j) '_ContourLog.json']);
                            val = jsondecode(fileread(fname));
                            Data_SP_40{p}{i+1,j+1} = val.data;
                        else
                            fname = (['NA' num2str(part(p)) 'A_0' num2str(i) '_000_00' num2str(j) '_ContourLog.json']);
                            val = jsondecode(fileread(fname));
                            Data_SP_40{p}{i+1,j+1} = val.data;
                        end
                    else if (p > 6 && p < 9)
                            if i < 10
                                
                                fname = (['CA' num2str(part(p)) 'A_00' num2str(i) '_002_00' num2str(j) '_ContourLog.json']);
                                val = jsondecode(fileread(fname));
                                Data_SP_40{p}{i+1,j+1} = val.data;
                            else
                                
                                fname = (['CA' num2str(part(p)) 'A_0' num2str(i) '_002_00' num2str(j) '_ContourLog.json']);
                                val = jsondecode(fileread(fname));
                                Data_SP_40{p}{i+1,j+1} = val.data;
                            end
                        else if p == 6
                                if i < 10
                                    fname = (['CA' num2str(part(p)) 'B_00' num2str(i) '_002_00' num2str(j) '_ContourLog.json']);
                                    val = jsondecode(fileread(fname));
                                    Data_SP_40{p}{i+1,j+1} = val.data;
                                else
                                    fname = (['CA' num2str(part(p)) 'B_0' num2str(i) '_002_00' num2str(j) '_ContourLog.json']);
                                    val = jsondecode(fileread(fname));
                                    Data_SP_40{p}{i+1,j+1} = val.data;
                                end
                            else
                                if i < 10
                                    fname = (['NA' num2str(part(p)) 'A_00' num2str(i) '_002_00' num2str(j) '_ContourLog.json']);
                                    val = jsondecode(fileread(fname));
                                    Data_SP_40{p}{i+1,j+1} = val.data;
                                else
                                    fname = (['NA' num2str(part(p)) 'A_0' num2str(i) '_002_00' num2str(j) '_ContourLog.json']);
                                    val = jsondecode(fileread(fname));
                                    Data_SP_40{p}{i+1,j+1} = val.data;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
%% Separating inducers (count) and orientation jitters
Data_SP_40 = Data_SP_40';

%% Getting the inducer thresholds

% for p = 1:length(Data_SP_40)
%     for i = 1:length(Data_SP_40{p,1})
%         if i == 1
%             continue;
%         end
%         for j = 1:2 %size(Data{p,1},2)
%             if isempty(Data_SP_40{p,1}{i,j}) == 1
%                 continue;
%             else
%                 [~, idx] = unique([Data_SP_40{p,1}{i,j}.inducers].', 'rows', 'stable');
%                 [~, idx2] = unique([Data_SP_40{p,1}{i,j}.orientationJitter].','rows','stable');
%                 if j == 2
%                     count = [];
%                     for k = 1:length(Data_SP_40{p,1}{i,j})
%                         count = [count ; Data_SP_40{p,1}{i,j}(k,1).inducers];
%                     end
%                     thresh = [];
%                     flag = 0;
%                     for ii = 1:length(count) - 1
%                         c = 0;
%                         if count(ii+1) < count(ii) && flag == 0
%                             thresh = [thresh ; count(ii)];
%                             flag = 1;
%                         end
%                         if count(ii+1) > count(ii) && flag == 1
%                             thresh = [thresh ; count(ii)];
%                             flag = 0;
%                         end
%                     end
%                     avg_thresh = mean(thresh);
%                     Thresh{1,j} = avg_thresh;
%                 end
%             end
%         end
%         Thresh_mat = cell2mat(Thresh);
%         Avg_Count_Thresh{p,1}{i,1} = mean(Thresh_mat);
%     end
% end
% Avg_Count_Thresh = cellfun(@empty2nan, Avg_Count_Thresh, 'UniformOutput', false);
%
% for p = 1:length(Data_SP_40)
%     average = mean(cell2mat(Avg_Count_Thresh{p,1}), 'omitnan');
%     se_val{p,1} =  abs(cell2mat(Avg_Count_Thresh{p,1}) - average);
% end
%
% for i = 1:40
%     Avg = [];
%     SE_Avg = [];
%     for p = 1:length(Data_SP_40)
%         avg = cell2mat(Avg_Count_Thresh{p,1}(i,1));
%         se_avg = se_val{p,1}(i,1);
%         Avg = [Avg; avg];
%         SE_Avg = [SE_Avg; se_avg];
%     end
%     Count_avg_SC{i,1} = mean(Avg, 'omitnan');
% %     Count_avg_SC{i,1} = 1./ Count_avg_SC{i,1};
% %     Count_avg_SC{i,1} = log10(Count_avg_SC{i,1});
%     Count_SD_SC{i,1} = std(SE_Avg, 'omitnan');
% end
%
% Count_SE_SC = cell2mat(Count_SD_SC) ./ (length(part))^(1/2);
%
% %% Plotting the Average Count data for all participants over 40 training sessions
% % load('Contour_Count_Avg_Healthy.mat')
% % load('Contour_Count_SD_Healthy.mat')
% load('Count_Thresh_Healthy_40.mat')
% load('Count_SE_Healthy_40.mat')
% figure(1);
% x1 = 2:40;
% y1 = cell2mat(Count_avg_SC);
% y1 = y1(2:40);
% error1 = Count_SE_SC(2:40);
% h_plot(1) = errorbar(x1,y1,error1,'.b', 'MarkerSize', 12, 'DisplayName', 'SP(n=23)')
% grid on;
% hold on;
% fit1 = polyfit(x1,y1,1);
% h_plot(2) = plot(x1, fit1(1)*x1 + fit1(2), '--b', 'DisplayName', 'Fit- SP')
% l = legend('show'); l.Location = 'best';
%
% x2 = 2:40;
% y2 = cell2mat(Count_avg);
% y2 = y2(2:40);
% error2 = Count_SE(2:40);
% hold on;
% h_plot(1) = errorbar(x2,y2,error2,'.r', 'MarkerSize', 12, 'DisplayName', 'NT(n=15)')
% grid on;
% hold on;
% fit2 = polyfit(x2,y2,1);
% h_plot(2) = plot(x2, fit2(1)*x2 + fit2(2), '--r', 'DisplayName', 'Fit- NT')
% l = legend('show'); l.Location = 'best';
% title('Contour Inducer Threshold (20 Sessions)', 'fontsize', 14)
% xlabel('Training Sessions')
% ylabel('Inducers')
%
%
% % subplot(4,2,2)
% for i = 1:40
%         hold on;
%         errorbar(i,Count_avg_SC{i,1},Count_SE_SC(i,1),'.b','MarkerSize',12);
%         a = get(gca,'Children');
%
%     hold on;
%         hold on;
%         errorbar(i,Count_avg{i,1},Count_SE(i,1),'.r','MarkerSize',12)
%         b = get(gca,'Children');
%
% end
% hold on;
% h = [b;a]
% xlim([0,40])
% title('Contour Count Threshold (40 Sessions)', 'fontsize', 14)
% xlabel('Training Sessions')
% ylabel('Inducers')
% % legend('Schizo Subjects','location','southeast');
% legend(h,'NT (n = 7)','SP (n = 11)','location','southeast');

%% Isolating contour orientation jitter information according to inducer level

% Getting the orientation jitter thresholds
% clear all
% clc

% part = [1005, 1018, 1019, 1028, 1005, 1006, 1018];
% load('Data_Schizo_Contour.mat')

for p = 1:length(Data)
    for i = 1:length(Data{p,1})
        if i == 1
            continue;
        end
        for j = 1:2 %size(Data{p,1},2)
            if isempty(Data{p,1}{i,j}) == 1
                continue;
            else
                [~, idx] = unique([Data{p,1}{i,j}.inducers].', 'rows', 'stable');
                [~, idx2] = unique([Data{p,1}{i,j}.orientationJitter].','rows','stable');
                if j == 1
                    count = [];
                    for k = 1:length(Data{p,1}{i,j})
                        count = [count ; Data{p,1}{i,j}(k,1).orientationJitter];
                    end
                    thresh = [];
                    flag = 0;
                    for ii = 1:length(count) - 1
                        c = 0;
                        if count(ii+1) < count(ii) && flag == 0
                            thresh = [thresh ; count(ii)];
                            flag = 1;
                        end
                        if count(ii+1) > count(ii) && flag == 1
                            thresh = [thresh ; count(ii)];
                            flag = 0;
                        end
                    end
                    avg_thresh = mean(thresh);
                    Thresh{1,j} = avg_thresh;
                end
            end
        end
        Thresh_mat = cell2mat(Thresh);
        Avg_OJ_Thresh{p,1}{i,1} = mean(Thresh_mat);
    end
end
Avg_OJ_Thresh = cellfun(@empty2nan, Avg_OJ_Thresh, 'UniformOutput', false);

for p = 1:length(part)
    average = mean(cell2mat(Avg_OJ_Thresh{p,1}), 'omitnan');
    se_val{p,1} =  abs(cell2mat(Avg_OJ_Thresh{p,1}) - average);
end

for i = 1:20
    Avg = [];
    SE_Avg = [];
    for p = 1:length(part)
        avg = cell2mat(Avg_OJ_Thresh{p,1}(i,1));
        se_avg = se_val{p,1}(i,1);
        Avg = [Avg; avg];
        SE_Avg = [SE_Avg; se_avg];
    end
    OJ_avg_SC{i,1} = mean(Avg, 'omitnan');
    %     OJ_avg_SC{i,1} = 1./ OJ_avg_SC{i,1};
    %     OJ_avg_SC{i,1} = log10(OJ_avg_SC{i,1});
    OJ_SD_SC{i,1} = std(SE_Avg, 'omitnan');
end

OJ_SE_SC = cell2mat(OJ_SD_SC) ./ (length(part))^(1/2);

% Plotting the Average Count data for all participants over 40 training sessions
% load('Contour_OJ_Healthy.mat')
% load('Contour_OJ_SD_HEalthy.mat')
load('OJ_Thresh_Healthy_40.mat')
load('OJ_SE_Healthy_40.mat')
figure(2);
x1 = 2:40;
y1 = cell2mat(OJ_avg_SC);
y1 = y1(2:40);
error1 = OJ_SE_SC(2:40);
h_plot(1) = errorbar(x1,y1,error1,'.b', 'MarkerSize', 12, 'DisplayName', 'SP(n=11)')
grid on;
hold on;
fit1 = polyfit(x1,y1,1);
h_plot(2) = plot(x1, fit1(1)*x1 + fit1(2), '--b', 'DisplayName', 'Fit- SP')
l = legend('show'); l.Location = 'best';

x2 = 2:40;
y2 = cell2mat(OJ_avg);
y2 = y2(2:40);
error2 = OJ_SE(2:40);
hold on;
h_plot(1) = errorbar(x2,y2,error2,'.r', 'MarkerSize', 12, 'DisplayName', 'NT(n=7)')
grid on;
hold on;
fit2 = polyfit(x2,y2,1);
h_plot(2) = plot(x2, fit2(1)*x2 + fit2(2), '--r', 'DisplayName', 'Fit- NT')
l = legend('show'); l.Location = 'best';
title('Contour Orientation Jitter Threshold (40 Sessions)', 'fontsize', 14)
xlabel('Training Sessions')
ylabel('Orientation')

%% Plotting individual participant tracks
% Orientation Jitter Info - Correct and incorrect responses
ses = [ 2, 7, 14, 19];
for ii = 1:length(ses)
    if ii < 3
        fname = (['CA1005A_00' num2str(ses(ii)) '_000_001_ContourClick.json']);%D_00' num2str(i) '_000_00' num2str(j) '_ContourLog.json']);
        val = jsondecode(fileread(fname));
        Data_click{ii} = val.data;
    else
        if ii > 2
            fname = (['CA1005A_0' num2str(ses(ii)) '_000_001_ContourClick.json']);%D_00' num2str(i) '_000_00' num2str(j) '_ContourLog.json']);
            val = jsondecode(fileread(fname));
            Data_click{ii} = val.data;
        end
    end
end
Target = "Target";
for jj = 1:length(Data_click)
    trial_no = [];
    for kk = 1:length(Data_click{1,jj})
        if contains(Data_click{1,jj}(kk).type, Target)
            trial_no = [trial_no; Data_click{1,jj}(kk).trial];
        end
    end
    trial{jj} = trial_no;
end

% for l = 1:length(ses)
%     trial{1,l} = padarray(trial{1,l},(length(Data{1,1}{ses(l)+1,1}) - length(trial{1,l})),'post');
% end

figure(3);
for i = 1: length(ses)
    subplot(2,2,i)
    for j = 1:length(Data_SP_40{1,1}{ses(i)+1,2})
        check = ismember(Data_SP_40{1,1}{ses(i)+1,2}(j).trial,trial{1,i});
        if check == 1
            plot(j , Data_SP_40{1,1}{ses(i)+1,2}(j).inducers, '.k', 'MarkerSize', 15)
            %             a = get(gca,'Children');
            hold on;
        else
            plot(j , Data_SP_40{1,1}{ses(i)+1,2}(j).inducers, '.r', 'MarkerSize', 15)
            %             b = get(gca,'Children');
            hold on;
        end
    end
    %     h = [a;b]
    title(['Inducers - Session ' num2str(ses(i)+1) ], 'fontsize', 14)
    xlabel('Trials per session')
    ylabel('Inducer (count)')
    % legend(h,'Correct Trials','Error Trials','location','southeast');
end


sgtitle('Individual Tracks for SP - 01', 'fontsize', 25)