clc;
clear;

while 1

    disp(' ');
    disp('=========================================');
    disp('HOSPITAL EMERGENCY DEPARTMENT SIMULATION');
    disp('=========================================');

    disp('1. Baseline Scenario');
    disp('2. Improved Scenario');
    disp('3. Compare Scenarios');
    disp('4. Previous Results');
    disp('5. Exit');

    choice = input('Select Option : ');

    switch choice

    % =====================================
    % BASELINE
    % =====================================
    case 1
        
        while 1

            disp(' ');
            disp('========== BASELINE ==========');
            disp('1. Service Time Table');
            disp('2. Interarrival Table');
            disp('3. Run Simulation');
            disp('4. Back');

            subChoice = input('Select Option : ');

            switch subChoice

            case 1
                
                ShowServiceTable;


            case 2

                ShowInterarrivalTable;


            case 3

                disp('=================================');
                disp('SIMULATION ASSUMPTIONS');
                disp('=================================');
                disp(' ');
                disp('Scenario: Baseline');
                disp(' ');
                disp('Number of Doctors: 3');
                disp(' ');
                disp('--------------------');
                disp('Patient Distribution');
                disp('--------------------');
                disp('| Green   | 50%    | ');
                disp('| Yellow  | 30%    | ');
                disp('| Red     | 20%    | ');
                disp('--------------------');
                disp('Queue Discipline: Priority Queue');
                disp(' ');
                disp(' ');

                custAmount = input('Enter number of patient for simulation: ');
                disp('Select Arrival Pattern');
                disp('1. Peak Hour');
                disp('2. Non-Peak Hour');
                peakchoice = input('Please Select option: ');

                disp('Select your random number generator: ');
                disp('1. Default rand function');
                disp('2. Linear Congruential Generator (LCG)');
                disp('3. Uniform Distribution Generator (LCG-based)');
                numGenChoice = input('Enter your choice:')

                numDoctors = 3;

                runSimulation( ...
                    custAmount,...
                    peakchoice,...
                    numGenChoice,...
                    numDoctors);

            case 4

                break;

            otherwise

                disp('Invalid Option');

            end

        end

    % =====================================
    % IMPROVED
    % =====================================
    case 2
        

        while 1

            disp(' ');
            disp('========== IMPROVED ==========');
            disp('1. Service Time Table');
            disp('2. Interarrival Table');
            disp('3. Run Simulation');
            disp('4. Back');

            subChoice = input('Select Option : ');

            switch subChoice

            case 1
                ShowServiceTable;



            case 2

                ShowInterarrivalTime;

            case 3

                disp('=================================');
                disp('SIMULATION ASSUMPTIONS');
                disp('=================================');
                disp(' ');
                disp('Scenario: Improved');
                disp(' ');
                disp('Number of Doctors: 4');
                disp(' ');
                disp('--------------------');
                disp('Patient Distribution');
                disp('--------------------');
                disp('| Green   | 50%    | ');
                disp('| Yellow  | 30%    | ');
                disp('| Red     | 20%    | ');
                disp('--------------------');
                disp('Queue Discipline: Priority Queue');
                disp(' ');
                disp(' ');

                custAmount = input('Enter number of patient for simulation: ');
                disp('Select Arrival Pattern');
                disp('1. Peak Hour');
                disp('2. Non-Peak Hour');
                peakchoice = input('Please Select option: ');

                disp('Select your random number generator: ');
                disp('1. Default rand function');
                disp('2. Linear Congruential Generator (LCG)');
                disp('3. Uniform Distribution Generator (LCG-based)');
                numGenChoice = input('Enter your choice:')
                numDoctors = 4;
                runSimulation( ...
                    custAmount,...
                    peakchoice,...
                    numGenChoice,...
                    numDoctors);

            case 4

                break;                

            otherwise

                disp('Invalid Option');

            end

        end

    % =====================================
    % COMPARE
    % =====================================
    case 3

        disp(' ');
        disp('Compare Scenario Module');

    % =====================================
    % PREVIOUS RESULTS
    % =====================================
    case 4

        disp(' ');
        disp('Previous Results Module');

    % =====================================
    % EXIT
    % =====================================
    case 5

        disp('System Terminated');
        break;

    otherwise

        disp('Invalid Option');

    end

end