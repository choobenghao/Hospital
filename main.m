clc;
clear;

simulationTime = 480;
meanArrival = 5;
meanService = 10;
numPatients = 200;

fprintf('BASELINE SCENARIO\n');
result1 = runSimulation(3,simulationTime,...
                        meanArrival,...
                        meanService,...
                        numPatients);

fprintf('\nIMPROVEMENT SCENARIO\n');
result2 = runSimulation(4,simulationTime,...
                        meanArrival,...
                        meanService,...
                        numPatients);

compareScenario(result1,result2);