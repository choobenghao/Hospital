function runSimulation(custAmount,peakchoice,numGenChoice,numDoctors, scenarioName)

N = custAmount;
seed = 12345;
a = 1103515245;
c = 12345;
m = 32768;

RN_IA = zeros(N,1);
IA = zeros(N,1);
Arrival = zeros(N,1);
RN_Type = zeros(N,1);
Priority = zeros(N,1);

PatientType = cell(N,1);

RN_Service = zeros(N,1);
ServiceTime = zeros(N,1);



Arrival(1) = 0;
IA(1) = 0;
RN_IA(1) = 0;

for i = 2:N

    % Random Number Generator
    switch numGenChoice

        % =================================
        % 1. Default rand()
        % =================================
        case 1
            RN_IA(i) = floor(rand()*100);

        % =================================
        % 2. Linear Congruential Generator
        % =================================
        case 2

            seed = mod(a*seed + c,m);

            RN_IA(i) = mod(seed,100);

        % =================================
        % 3. Uniform Distribution (LCG)
        % =================================
        case 3
            seed = mod(a*seed + c,m);

            U = seed/m;

            RN_IA(i) = floor(U*100);

    end

    % Peak Hour
    if peakchoice == 1

        if RN_IA(i) <= 14

            IA(i) = 0;

        elseif RN_IA(i) <= 49

            IA(i) = 1;

        elseif RN_IA(i) <= 79

            IA(i) = 2;

        else

            IA(i) = 3;

        end

    % Non-Peak Hour
    else

        if RN_IA(i) <= 19

            IA(i) = 2;

        elseif RN_IA(i) <= 49

            IA(i) = 3;

        elseif RN_IA(i) <= 79

            IA(i) = 4;

        else

            IA(i) = 5;

        end 

    end

    Arrival(i) = Arrival(i-1) + IA(i);

end

for i = 1:N

    RN_Type(i) = floor(rand()*100);

    if RN_Type(i) <= 19

        PatientType{i} = 'RED';
        Priority(i) = 3;

    elseif RN_Type(i) <= 49

        PatientType{i} = 'YELLOW';
        Priority(i) = 2;

    else

        PatientType{i} = 'GREEN';
        Priority(i) = 1;

    end

end

%serviceRN and service time

for i = 1:N

    RN_Service(i) = floor(rand()*100);

    if strcmp(PatientType{i},'GREEN')

        if RN_Service(i) <= 9

            ServiceTime(i) = 4;

        elseif RN_Service(i) <= 29

            ServiceTime(i) = 5;

        elseif RN_Service(i) <= 69

            ServiceTime(i) = 6;

        elseif RN_Service(i) <= 89

            ServiceTime(i) = 7;

        else

            ServiceTime(i) = 8;

        end

    elseif strcmp(PatientType{i},'YELLOW')

        if RN_Service(i) <= 9

            ServiceTime(i) = 6;

        elseif RN_Service(i) <= 29

            ServiceTime(i) = 8;

        elseif RN_Service(i) <= 69

            ServiceTime(i) = 10;

        elseif RN_Service(i) <= 89

            ServiceTime(i) = 12;

        else

            ServiceTime(i) = 15;

        end

    elseif strcmp(PatientType{i},'RED')

        if RN_Service(i) <= 9

            ServiceTime(i) = 10;

        elseif RN_Service(i) <= 29

            ServiceTime(i) = 15;

        elseif RN_Service(i) <= 69

            ServiceTime(i) = 20;

        elseif RN_Service(i) <= 89

            ServiceTime(i) = 25;

        else

            ServiceTime(i) = 30;

        end

    end

end

QueueTable = zeros(N,4);

for i = 1:N

    QueueTable(i,1) = i;
    QueueTable(i,2) = Priority(i);
    QueueTable(i,3) = Arrival(i);
    QueueTable(i,4) = ServiceTime(i);

end


%sort table

for i = 1:N-1

    for j = i+1:N

        swap = 0;

        if QueueTable(j,2) > QueueTable(i,2)

            swap = 1;

        elseif QueueTable(j,2) == QueueTable(i,2)

            if QueueTable(j,3) < QueueTable(i,3)

                swap = 1;

            end

        end

        if swap == 1

            temp = QueueTable(i,:);

            QueueTable(i,:) = QueueTable(j,:);

            QueueTable(j,:) = temp;

        end

    end

end

SortedID = QueueTable(:,1);

SortedArrival = zeros(N,1);
SortedPriority = zeros(N,1);
SortedService = zeros(N,1);

SortedType = cell(N,1);

for i = 1:N

    id = SortedID(i);

    SortedArrival(i) = Arrival(id);

    SortedPriority(i) = Priority(id);

    SortedService(i) = ServiceTime(id);

    SortedType{i} = PatientType{id};

end





disp(' ');
disp('=================================');
disp('ARRIVAL TABLE');
disp('=================================');

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

for i = 1:N

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



disp(' ');
disp('==============================================');
disp('PRIORITY QUEUE');
disp('==============================================');

fprintf('%-5s %-8s %-10s %-10s %-10s\n',...
        'ID',...
        'Arrival',...
        'Type',...
        'Priority',...
        'Service');


for i = 1:N

fprintf('%-5d %-8d %-10s %-10d %-10d\n',...
        SortedID(i),...
        SortedArrival(i),...
        SortedType{i},...
        SortedPriority(i),...
        SortedService(i));

end


%doctor schedule

DoctorAssigned = zeros(N,1);

StartTime = zeros(N,1);
EndTime = zeros(N,1);

WaitingTime = zeros(N,1);
SystemTime = zeros(N,1);

DoctorFinishTime = zeros(1,numDoctors);
DoctorBusyTime = zeros(1,numDoctors);

for i = 1:N

    [EarliestTime,doc] = min(DoctorFinishTime);

    DoctorAssigned(i) = doc;

    StartTime(i) = ...
        max(SortedArrival(i),EarliestTime);

    WaitingTime(i) = ...
        StartTime(i) - SortedArrival(i);

    EndTime(i) = ...
        StartTime(i) + SortedService(i);

    SystemTime(i) = ...
        EndTime(i) - SortedArrival(i);

    DoctorFinishTime(doc) = EndTime(i);

    DoctorBusyTime(doc) = ...
        DoctorBusyTime(doc) + SortedService(i);

end

disp(' ');
disp('==============================================');
disp('EVENT TABLE');
disp('==============================================');

fprintf('%-5s %-6s %-10s %-6s %-6s %-8s %-8s %-8s %-8s\n',...
        'ID',...
        'Arr',...
        'Type',...
        'Pri',...
        'Doc',...
        'Start',...
        'End',...
        'Wait',...
        'Sys');
for i = 1:N

fprintf('%-5d %-6d %-10s %-6d %-6d %-8d %-8d %-8d %-8d\n',...
        SortedID(i),...
        SortedArrival(i),...
        SortedType{i},...
        SortedPriority(i),...
        DoctorAssigned(i),...
        StartTime(i),...
        EndTime(i),...
        WaitingTime(i),...
        SystemTime(i));

end   

disp(' ');
disp('DEPARTURE EVENTS');

for i = 1:N

fprintf('Customer %d departed at minute %d\n',...
        SortedID(i),...
        EndTime(i));

end

AverageWaitingTime = mean(WaitingTime);
AverageSystemTime = mean(SystemTime);
AverageServiceTime = mean(ServiceTime);
AverageInterArrival = mean(IA);
NumWait = sum(WaitingTime > 0);

ProbabilityWait = ...
    (NumWait/N)*100;

Makespan = max(EndTime);

DoctorUtilization = ...
    (DoctorBusyTime/Makespan)*100;

disp(' ');
disp('==============================================');
disp('DOCTOR UTILIZATION');
disp('==============================================');

for d = 1:numDoctors

fprintf('Doctor %d Utilization : %.2f %%\n',...
        d,...
        DoctorUtilization(d));

end

OverallUtilization = ...
(sum(DoctorBusyTime) / ...
(Makespan*numDoctors))*100;

PatientsInQueue = sum(WaitingTime > 0);

AverageQueueLength = ...
PatientsInQueue / N;

disp(' ');
disp('==============================================');
disp('PERFORMANCE METRICS');
disp('==============================================');

fprintf('Patients Served      : %d\n',N);

fprintf('Average Waiting Time : %.2f\n',...
        AverageWaitingTime);

fprintf('Average System Time  : %.2f\n',...
        AverageSystemTime);

fprintf('Average Service Time : %.2f\n',...
        AverageServiceTime);

fprintf('Average InterArrival : %.2f\n',...
        AverageInterArrival);

fprintf('Probability Wait     : %.2f %%\n',...
        ProbabilityWait);

fprintf('Makespan             : %.2f\n',...
        Makespan);

fprintf('Overall Utilization  : %.2f %%\n',...
        OverallUtilization);

fprintf('Average Queue Length : %.2f\n',...
        AverageQueueLength);


disp(' ');

SaveChoice = input(...
'Do you want to save this simulation? (1=Yes, 2=No): ');

if SaveChoice == 1

    if strcmp(scenarioName,'BASELINE')

    FolderName = 'Baseline';

    else

        FolderName = 'Improved';

    end

    if exist(FolderName) == 0

        mkdir(FolderName);

    end

    files = dir([FolderName filesep '*.txt']);

    CaseNumber = length(files) + 1;

    FileName = sprintf(...
    'CASE_%03d_%s.txt',...
    CaseNumber,...
    scenarioName);

    FullFileName = ...
    [FolderName filesep FileName];

    fid = fopen(FullFileName,'w');

    fprintf(fid,'=========================================\n');
    fprintf(fid,'EMERGENCY DEPARTMENT SIMULATION RESULT\n');
    fprintf(fid,'=========================================\n\n');

    fprintf(fid,'Scenario               : %s\n',scenarioName);
    fprintf(fid,'Number of Doctors      : %d\n',numDoctors);
    fprintf(fid,'Patients Served        : %d\n',N);

    fprintf(fid,'Average Waiting Time   : %.2f\n',AverageWaitingTime);
    fprintf(fid,'Average System Time    : %.2f\n',AverageSystemTime);
    fprintf(fid,'Average Service Time   : %.2f\n',AverageServiceTime);
    fprintf(fid,'Average InterArrival   : %.2f\n',AverageInterArrival);
    fprintf(fid,'Probability Wait       : %.2f %%\n',ProbabilityWait);
    fprintf(fid,'Makespan               : %.2f\n',Makespan);
    fprintf(fid,'Average Queue Length : %.2f\n',AverageQueueLength);
    fprintf(fid,'Overall Utilization    : %.2f %%\n',OverallUtilization);

    fprintf(fid,'\n');
    fprintf(fid,'=========================================\n');
    fprintf(fid,'PATIENT DETAILS\n');
    fprintf(fid,'=========================================\n');

    fprintf(fid,...
    '%-5s %-8s %-8s %-10s %-8s %-10s %-8s %-8s %-8s %-8s\n',...
    'ID',...
    'Arrival',...
    'RN_Type',...
    'Type',...
    'Priority',...
    'Service',...
    'Doctor',...
    'Start',...
    'End',...
    'Wait');

    fprintf(fid,...
    '-------------------------------------------------------------------------------\n');

    for i = 1:N

        fprintf(fid,...
        '%-5d %-8d %-8d %-10s %-8d %-10d %-8d %-8d %-8d %-8d\n',...
        SortedID(i),...
        SortedArrival(i),...
        RN_Type(SortedID(i)),...
        SortedType{i},...
        SortedPriority(i),...
        SortedService(i),...
        DoctorAssigned(i),...
        StartTime(i),...
        EndTime(i),...
        WaitingTime(i));

    end

    fprintf(fid,'\n');
    fprintf(fid,'=========================================\n');
    fprintf(fid,'DEPARTURE EVENTS\n');
    fprintf(fid,'=========================================\n');

    for i = 1:N

        fprintf(fid,...
        'Customer %-3d departed at minute %-5d\n',...
        SortedID(i),...
        EndTime(i));

    end

    fclose(fid);

    fprintf('\nResult Saved : %s\n',...
        FullFileName);

end



end