% ==========================
% STEP 12 : COMPARE SCENARIOS
% ==========================

disp(' ');
disp('COMPARE SCENARIOS');
disp('--------------------------');

files = dir('CASE*.txt');

for i = 1:length(files)

    fprintf('%d. %s\n', ...
            i, ...
            files(i).name);

end

disp(' ');

baselineChoice = input('Select Baseline Case : ');
improvedChoice = input('Select Improved Case : ');

baselineFile = files(baselineChoice).name;
improvedFile = files(improvedChoice).name;

% ==========================
% READ BASELINE
% ==========================

fid = fopen(baselineFile,'r');

baselineWait = 0;
baselineQueue = 0;
baselineUtil = 0;
baselineMakespan = 0;

while ~feof(fid)

    line = fgetl(fid);

    if ~isempty(strfind(line,'Average Waiting Time'))

        temp = sscanf(line,...
        'Average Waiting Time : %f');

        baselineWait = temp;

    end

    if ~isempty(strfind(line,'Average Queue Length'))

        temp = sscanf(line,...
        'Average Queue Length : %f');

        baselineQueue = temp;

    end

    if ~isempty(strfind(line,'Overall Utilization'))

        temp = sscanf(line,...
        'Overall Utilization : %f');

        baselineUtil = temp;

    end

    if ~isempty(strfind(line,'Makespan'))

        temp = sscanf(line,...
        'Makespan : %f');

        baselineMakespan = temp;

    end

end

fclose(fid);

% ==========================
% READ IMPROVED
% ==========================

fid = fopen(improvedFile,'r');

improvedWait = 0;
improvedQueue = 0;
improvedUtil = 0;
improvedMakespan = 0;

while ~feof(fid)

    line = fgetl(fid);

    if ~isempty(strfind(line,'Average Waiting Time'))

        temp = sscanf(line,...
        'Average Waiting Time : %f');

        improvedWait = temp;

    end

    if ~isempty(strfind(line,'Average Queue Length'))

        temp = sscanf(line,...
        'Average Queue Length : %f');

        improvedQueue = temp;

    end

    if ~isempty(strfind(line,'Overall Utilization'))

        temp = sscanf(line,...
        'Overall Utilization : %f');

        improvedUtil = temp;

    end

    if ~isempty(strfind(line,'Makespan'))

        temp = sscanf(line,...
        'Makespan : %f');

        improvedMakespan = temp;

    end

end

fclose(fid);

% ==========================
% CALCULATE IMPROVEMENT
% ==========================

if baselineWait ~= 0

    waitImprove = ...
    ((baselineWait-improvedWait) ...
    / baselineWait)*100;

else

    waitImprove = 0;

end

queueImprove = ...
((baselineQueue - improvedQueue) ...
/ baselineQueue) * 100;

makespanImprove = ...
((baselineMakespan - improvedMakespan) ...
/ baselineMakespan) * 100;

% ==========================
% DISPLAY RESULT
% ==========================

disp(' ');
disp('=========================================');
disp('SCENARIO COMPARISON');
disp('=========================================');

fprintf('\n');

fprintf('Metric                     Baseline      Improved\n');

fprintf('-------------------------------------------------\n');

fprintf('Average Waiting Time       %.2f         %.2f\n',...
        baselineWait,...
        improvedWait);

fprintf('Average Queue Length       %.2f         %.2f\n',...
        baselineQueue,...
        improvedQueue);

fprintf('Overall Utilization        %.2f%%        %.2f%%\n',...
        baselineUtil,...
        improvedUtil);

fprintf('Makespan                   %.2f         %.2f\n',...
        baselineMakespan,...
        improvedMakespan);

fprintf('\n');

disp('IMPROVEMENT');

fprintf('Waiting Time Reduced   : %.2f %%\n',...
        waitImprove);

fprintf('Queue Length Reduced   : %.2f %%\n',...
        queueImprove);

fprintf('Makespan Reduced       : %.2f %%\n',...
        makespanImprove);