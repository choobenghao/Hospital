function compareScenario()

clc;

disp(' ');
disp('=========================================');
disp('COMPARE SCENARIOS');
disp('=========================================');

custAmount = input('Enter Number of Patients : ');

disp(' ');
disp('Select Arrival Pattern');
disp('1. Peak Hour');
disp('2. Non-Peak Hour');

peakchoice = input('Select Option : ');

disp(' ');
disp('Select Random Number Generator');
disp('1. Default rand');
disp('2. LCG');
disp('3. Uniform');

numGenChoice = input('Select Option : ');

N = custAmount;

RN_IA = zeros(N,1);
IA = zeros(N,1);
Arrival = zeros(N,1);

Arrival(1)=0;

for i=2:N

    RN_IA(i)=floor(rand()*100);

    if peakchoice==1

        if RN_IA(i)<=14

            IA(i)=0;

        elseif RN_IA(i)<=49

            IA(i)=1;

        elseif RN_IA(i)<=79

            IA(i)=2;

        else

            IA(i)=3;

        end

    else

        if RN_IA(i)<=19

            IA(i)=2;

        elseif RN_IA(i)<=49

            IA(i)=3;

        elseif RN_IA(i)<=79

            IA(i)=4;

        else

            IA(i)=5;

        end

    end

    Arrival(i)=Arrival(i-1)+IA(i);

end

RN_Type = zeros(N,1);
Priority = zeros(N,1);

PatientType = cell(N,1);

for i=1:N

    RN_Type(i)=floor(rand()*100);

    if RN_Type(i)<=19

        PatientType{i}='RED';
        Priority(i)=3;

    elseif RN_Type(i)<=49

        PatientType{i}='YELLOW';
        Priority(i)=2;

    else

        PatientType{i}='GREEN';
        Priority(i)=1;

    end

end

RN_Service = zeros(N,1);
ServiceTime = zeros(N,1);

for i=1:N

    RN_Service(i)=floor(rand()*100);

    if strcmp(PatientType{i},'GREEN')

        if RN_Service(i)<=9
            ServiceTime(i)=4;
        elseif RN_Service(i)<=29
            ServiceTime(i)=5;
        elseif RN_Service(i)<=69
            ServiceTime(i)=6;
        elseif RN_Service(i)<=89
            ServiceTime(i)=7;
        else
            ServiceTime(i)=8;
        end

    elseif strcmp(PatientType{i},'YELLOW')

        if RN_Service(i)<=9
            ServiceTime(i)=6;
        elseif RN_Service(i)<=29
            ServiceTime(i)=8;
        elseif RN_Service(i)<=69
            ServiceTime(i)=10;
        elseif RN_Service(i)<=89
            ServiceTime(i)=12;
        else
            ServiceTime(i)=15;
        end

    else

        if RN_Service(i)<=9
            ServiceTime(i)=10;
        elseif RN_Service(i)<=29
            ServiceTime(i)=15;
        elseif RN_Service(i)<=69
            ServiceTime(i)=20;
        elseif RN_Service(i)<=89
            ServiceTime(i)=25;
        else
            ServiceTime(i)=30;
        end

    end

end

disp(' ');
disp('=========================================');
disp('COMPARISON DATASET');
disp('=========================================');

fprintf('%-5s %-8s %-5s %-6s %-8s %-10s %-8s %-10s %-8s\n',...
        'ID',...
        'RN_IA',...
        'IA',...
        'Arr',...
        'RN_Type',...
        'Type',...
        'Priority',...
        'RN_Service',...
        'Service');

for i=1:N

fprintf('%-5d %-8d %-5d %-6d %-8d %-10s %-8d %-10d %-8d\n',...
        i,...
        RN_IA(i),...
        IA(i),...
        Arrival(i),...
        RN_Type(i),...
        PatientType{i},...
        Priority(i),...
        RN_Service(i),...
        ServiceTime(i));

end


disp('Running Baseline...');

[BaseWait,...
 BaseSystem,...
 BaseProbWait,...
 BaseMakespan,...
 BaseUtil] = ...
compareSimulationEngine(...
Arrival,...
RN_Type,...
PatientType,...
Priority,...
RN_Service,...
ServiceTime,...
3);

disp('Baseline Complete');

disp('Running Improved...');

[ImpWait,...
 ImpSystem,...
 ImpProbWait,...
 ImpMakespan,...
 ImpUtil] = ...
compareSimulationEngine(...
Arrival,...
RN_Type,...
PatientType,...
Priority,...
RN_Service,...
ServiceTime,...
4);

disp('Improved Complete');

WaitingImprove = ...
((BaseWait-ImpWait)/BaseWait)*100;

SystemImprove = ...
((BaseSystem-ImpSystem)/BaseSystem)*100;

MakespanImprove = ...
((BaseMakespan-ImpMakespan)/BaseMakespan)*100;

ProbImprove = ...
((BaseProbWait-ImpProbWait)/BaseProbWait)*100;

disp(' ');
disp('=========================================');
disp('SCENARIO COMPARISON');
disp('=========================================');

fprintf('Average Waiting Time\n');
fprintf('Baseline : %.2f\n',BaseWait);
fprintf('Improved : %.2f\n',ImpWait);
fprintf('Improvement : %.2f %%\n\n',...
        WaitingImprove);

fprintf('Average System Time\n');
fprintf('Baseline : %.2f\n',BaseSystem);
fprintf('Improved : %.2f\n',ImpSystem);
fprintf('Improvement : %.2f %%\n\n',...
        SystemImprove);

fprintf('Probability Wait\n');
fprintf('Baseline : %.2f %%\n',BaseProbWait);
fprintf('Improved : %.2f %%\n',ImpProbWait);
fprintf('Reduction : %.2f %%\n\n',...
        ProbImprove);

fprintf('Makespan\n');
fprintf('Baseline : %.2f\n',BaseMakespan);
fprintf('Improved : %.2f\n',ImpMakespan);
fprintf('Improvement : %.2f %%\n\n',...
        MakespanImprove);

fprintf('Overall Utilization\n');
fprintf('Baseline : %.2f %%\n',BaseUtil);
fprintf('Improved : %.2f %%\n',ImpUtil);

input('Press ENTER to continue...','s');

end