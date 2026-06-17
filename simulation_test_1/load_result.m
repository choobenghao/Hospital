% ==========================
% STEP 11 (ADVANCED)
% LIST ALL CASE FILES
% ==========================

disp(' ');
disp('AVAILABLE CASE FILES');
disp('--------------------------');

files = dir('CASE*.txt');

for i = 1:length(files)

    fprintf('%d. %s\n', ...
            i, ...
            files(i).name);

end

choice = input('Select File Number : ');

FileName = files(choice).name;

fid = fopen(FileName,'r');

disp(' ');
disp('===== RESULT =====');

while ~feof(fid)

    line = fgetl(fid);

    disp(line);

end

fclose(fid);