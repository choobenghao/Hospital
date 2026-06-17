
% ==========================
% STEP 13 : MAIN MENU SYSTEM
% ==========================

clc;
clear;

while 1

    disp(' ');
    disp('=========================================');
    disp('HOSPITAL EMERGENCY DEPARTMENT SIMULATION');
    disp('=========================================');

    disp('1. Run Baseline Scenario (3 Doctors)');
    disp('2. Run Improved Scenario (4 Doctors)');
    disp('3. Compare Scenarios');
    disp('4. Display Previous Results');
    disp('5. Exit');

    choice = input('Select Option : ');

    switch choice

        % =====================================
        % BASELINE
        % =====================================
        case 1

            numDoctors = 3;

            N = input('Enter Number of Patients : ');

            disp(' ');
            disp('BASELINE SCENARIO');
            disp('3 DOCTORS');

            % Run Step 1 ~ Step 10 here

            run_simulation;

        % =====================================
        % IMPROVED
        % =====================================
        case 2

            numDoctors = 4;

            N = input('Enter Number of Patients : ');

            disp(' ');
            disp('IMPROVED SCENARIO');
            disp('4 DOCTORS');

            % Run Step 1 ~ Step 10 here

            run_simulation;

        % =====================================
        % COMPARE
        % =====================================
        case 3

            % Run Step 12

            disp(' ');
            disp('COMPARE SCENARIOS');

            files = dir('CASE*.txt');

            for i = 1:length(files)

                fprintf('%d. %s\n',...
                        i,...
                        files(i).name);

            end

            disp(' ');

            baselineChoice = ...
            input('Select Baseline Case : ');

            improvedChoice = ...
            input('Select Improved Case : ');

            baselineFile = ...
            files(baselineChoice).name;

            improvedFile = ...
            files(improvedChoice).name;

            disp(' ');
            fprintf('Baseline : %s\n',baselineFile);
            fprintf('Improved : %s\n',improvedFile);

            compare_result();

        % =====================================
        % PREVIOUS RESULTS
        % =====================================
        case 4

            disp(' ');
            disp('PREVIOUS RESULTS');

            files = dir('CASE*.txt');
            if fileChoice < 1 || ...
            fileChoice > length(files)

                disp('Invalid Selection');

            else

                ...
            end

            if length(files) == 0

                disp('No Result Found');

            else

                for i = 1:length(files)

                    fprintf('%d. %s\n',...
                            i,...
                            files(i).name);

                end

                fileChoice = ...
                input('Select File : ');

                FileName = ...
                files(fileChoice).name;

                fid = fopen(FileName,'r');

                disp(' ');
                disp('===== RESULT =====');

                while ~feof(fid)

                    line = fgetl(fid);

                    disp(line);

                end

                fclose(fid);

            end

        % =====================================
        % EXIT
        % =====================================
        case 5

            disp(' ');
            disp('System Terminated');
            break;

        otherwise

            disp('Invalid Option');

    end

    disp(' ');
    input('Press ENTER to continue...','s');

    clc;

end









