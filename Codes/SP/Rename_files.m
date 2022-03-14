%% Renaming files
clear all
clc
files = dir ('*.json'); 
for i = 1:length(files) %1:93 %128:220
    [~,names] = fileparts(files(i).name);
    expression = 'STS(\w+)\d';
    name2replace = names(1:end-18);
    newname = regexprep(names,expression,name2replace);
    newjson = strcat(newname, '.json');
    %     cd NCT_2020_11
    movefile(files(i).name, newjson);
end