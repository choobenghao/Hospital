clc;
clear;

simulationTime = 480;
meanArrival = 5;
meanService = 10;
numPatients = 200;

fprintf('===== BASELINE (3 DOCTORS) =====\n');
result1 = runSimulation(3,...
                        simulationTime,...
                        meanArrival,...
                        meanService,...
                        numPatients);

fprintf('\n');

fprintf('===== IMPROVEMENT (4 DOCTORS) =====\n');
result2 = runSimulation(4,...
                        simulationTime,...
                        meanArrival,...
                        meanService,...
                        numPatients);

fprintf('\n');

compareScenario(result1,result2);