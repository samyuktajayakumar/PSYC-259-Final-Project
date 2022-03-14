function [Threshold] = isolate_threshold(input_mat)

for ii = 1:size(input_mat,1)
    for jj = 1:size(input_mat,2)
        if isempty(input_mat{ii,jj}) == 1
            avg_thresh_ori = NaN;
            Thresh_ori = NaN;
        else
            for kk = 1:length(input_mat{ii,jj})
                count_ori = [];
                for mm = 4:length(input_mat{ii,jj}{kk,1})                   
                    count_ori = [count_ori ; input_mat{ii,jj}{kk,1}(mm,1).orientationJitter];
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
        Threshold(ii,jj) = mean(Thresh_ori,'omitnan');
        clear avg_thresh_ori; clear Thresh_ori;
    end
end
