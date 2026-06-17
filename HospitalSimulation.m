clc;
clear;

result1 = [];
result2 = [];

choice = 0;

while choice ~= 5

    clc;

    disp('========================================');
    disp(' HOSPITAL EMERGENCY DEPARTMENT SYSTEM ');
    disp('========================================');
    disp('1. Run Baseline Scenario (3 Doctors)');
    disp('2. Run Improvement Scenario (4 Doctors)');
    disp('3. Compare Scenarios');
    disp('4. Display Previous Results');
    disp('5. Exit');
    disp('========================================');

    choice = input('Enter your choice: ');

    switch choice

        case 1

            disp(' ');
            disp('Running Baseline Scenario...');
            result1 = runSimulation(3,480,5,10,200);

            fprintf('\nAverage Waiting Time : %.2f\n', ...
                    result1.avgWaiting);

            fprintf('Average Queue Length : %.2f\n', ...
                    result1.avgQueue);

            fprintf('Doctor Utilization : %.2f%%\n', ...
                    result1.utilization*100);

            fprintf('Patients Served : %d\n', ...
                    result1.totalServed);

            input('\nPress ENTER to continue...','s');


        case 2

            disp(' ');
            disp('Running Improvement Scenario...');
            result2 = runSimulation(4,480,5,10,200);

            fprintf('\nAverage Waiting Time : %.2f\n', ...
                    result2.avgWaiting);

            fprintf('Average Queue Length : %.2f\n', ...
                    result2.avgQueue);

            fprintf('Doctor Utilization : %.2f%%\n', ...
                    result2.utilization*100);

            fprintf('Patients Served : %d\n', ...
                    result2.totalServed);

            input('\nPress ENTER to continue...','s');


        case 3

            if isempty(result1) || isempty(result2)

                disp('Please run both scenarios first.');

            else

                compareScenario(result1,result2);

            end

            input('\nPress ENTER to continue...','s');


        case 4

            if ~isempty(result1)

                disp(' ');
                disp('===== BASELINE =====');
                disp(result1);

            end

            if ~isempty(result2)

                disp(' ');
                disp('===== IMPROVEMENT =====');
                disp(result2);

            end

            input('\nPress ENTER to continue...','s');


        case 5

            disp(' ');
            disp('Program terminated.');
            disp('Thank you.');

        otherwise

            disp('Invalid choice.');
            input('\nPress ENTER to continue...','s');

    end

end