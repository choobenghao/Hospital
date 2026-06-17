
%% ==========================================
% EMERGENCY DEPARTMENT SIMULATION
%% ==========================================

if ~exist('N','var')

    N = input('Enter Number of Patients : ');

end

if ~exist('numDoctors','var')

    numDoctors = 3;

end

%% ==========================================
% STEP 1 : INITIALIZE VARIABLES
%% ==========================================

PatientID = (1:N)';

ArrivalTime = zeros(N,1);
InterArrival = zeros(N,1);

Priority = zeros(N,1);
ServiceTime = zeros(N,1);

WaitingTime = zeros(N,1);
SystemTime = zeros(N,1);

StartTime = zeros(N,1);
EndTime = zeros(N,1);

disp('Patient Table Created');

%% ==========================================
% STEP 2 : GENERATE ARRIVAL TIMES
%% ==========================================

ArrivalTime(1) = 0;

for i = 2:N

    InterArrival(i) = floor(rand()*5) + 1;
    

    ArrivalTime(i) = ArrivalTime(i-1) + InterArrival(i);

end

disp(' ');
disp('ARRIVAL TABLE');
disp('Patient    IA    Arrival');

for i = 1:N

    fprintf('%3d %8d %8d\n',...
        i,...
        InterArrival(i),...
        ArrivalTime(i));

end

%% ==========================================
% STEP 3 : ASSIGN PATIENT TYPE & PRIORITY
%% ==========================================

RN_Type = floor(rand(N,1)*100);
PatientType = cell(N,1);

for i = 1:N

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

disp(' ');
disp('PATIENT TYPE TABLE');
disp('Patient    Type      Priority');

for i = 1:N

    fprintf('%3d\t%s\t\t%d\n',...
        i,...
        PatientType{i},...
        Priority(i));

end

%% ==========================================
% STEP 4 : GENERATE SERVICE TIMES
%% ==========================================

RN_Service = floor(rand(N,1)*100);

for i = 1:N

    switch PatientType{i}

        case 'GREEN'

            if RN_Service(i) <= 29
                ServiceTime(i) = 5;
            elseif RN_Service(i) <= 69
                ServiceTime(i) = 10;
            else
                ServiceTime(i) = 15;
            end

        case 'YELLOW'

            if RN_Service(i) <= 24
                ServiceTime(i) = 10;
            elseif RN_Service(i) <= 74
                ServiceTime(i) = 15;
            else
                ServiceTime(i) = 20;
            end

        case 'RED'

            if RN_Service(i) <= 19
                ServiceTime(i) = 20;
            elseif RN_Service(i) <= 69
                ServiceTime(i) = 30;
            else
                ServiceTime(i) = 40;
            end

    end

end

disp(' ');
disp('SERVICE TIME TABLE');
disp('Patient   Type      RN    Service');

for i = 1:N

    fprintf('%3d\t%s\t%d\t%d\n',...
        i,...
        PatientType{i},...
        RN_Service(i),...
        ServiceTime(i));

end

%% ==========================================
% STEP 5 : PRIORITY QUEUE SORTING
%% ==========================================

SortedID = PatientID;

for i = 1:N-1

    for j = i+1:N

        swap = 0;

        % Higher priority first
        if Priority(SortedID(j)) > Priority(SortedID(i))

            swap = 1;

        % Same priority -> earlier arrival first
        elseif Priority(SortedID(j)) == Priority(SortedID(i))

            if ArrivalTime(SortedID(j)) < ArrivalTime(SortedID(i))

                swap = 1;

            end

        end

        if swap == 1

            temp = SortedID(i);
            SortedID(i) = SortedID(j);
            SortedID(j) = temp;

        end

    end

end

SortedArrival  = zeros(N,1);
SortedPriority = zeros(N,1);
SortedService  = zeros(N,1);
SortedType     = cell(N,1);

for i = 1:N

    SortedArrival(i)  = ArrivalTime(SortedID(i));
    SortedPriority(i) = Priority(SortedID(i));
    SortedService(i)  = ServiceTime(SortedID(i));
    SortedType{i}     = PatientType{SortedID(i)};

end

%% ==========================================
% STEP 6 : DOCTOR SCHEDULING
%% ==========================================

DoctorAssigned = zeros(N,1);

DoctorFinishTime = zeros(1,numDoctors);
DoctorBusyTime = zeros(1,numDoctors);

for i = 1:N

    [EarliestTime,doc] = min(DoctorFinishTime);

    DoctorAssigned(i) = doc;

    StartTime(i) = max(SortedArrival(i),EarliestTime);

    WaitingTime(i) = StartTime(i) - SortedArrival(i);

    EndTime(i) = StartTime(i) + SortedService(i);

    SystemTime(i) = EndTime(i) - SortedArrival(i);

    DoctorFinishTime(doc) = EndTime(i);

    DoctorBusyTime(doc) = DoctorBusyTime(doc) + SortedService(i);

end

disp(' ');
disp('EVENT TABLE');

fprintf('\n');
fprintf('ID Arr Type Pri Doc Start End Wait Sys\n');

for i = 1:N

    fprintf('%2d %3d %-6s %2d %3d %5d %4d %4d %4d\n',...
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

%% ==========================================
% STEP 7 : PERFORMANCE METRICS
%% ==========================================

AverageWaitingTime = mean(WaitingTime);
AverageSystemTime = mean(SystemTime);
AverageServiceTime = mean(SortedService);
AverageInterArrival = mean(InterArrival);

NumWait = sum(WaitingTime > 0);

ProbabilityWait = (NumWait/N)*100;

PatientsServed = N;

Makespan = max(EndTime);

%% ==========================================
% STEP 8 : DOCTOR UTILIZATION
%% ==========================================

DoctorUtilization = ...
    (DoctorBusyTime/Makespan)*100;

disp(' ');
disp('DOCTOR UTILIZATION');

for d = 1:numDoctors

    fprintf('Doctor %d Utilization : %.2f %%\n',...
        d,...
        DoctorUtilization(d));

end

OverallUtilization = ...
(sum(DoctorBusyTime)/(Makespan*numDoctors))*100;

fprintf('\nOverall Utilization : %.2f %%\n',...
    OverallUtilization);

%% ==========================================
% STEP 9 : QUEUE STATISTICS
%% ==========================================

QueueLength = zeros(N,1);

for i = 1:N

    count = 0;

    for j = 1:N

        if SortedArrival(j) <= SortedArrival(i) && ...
           StartTime(j) > SortedArrival(i)

            count = count + 1;

        end

    end

    QueueLength(i) = count;

end

AverageQueueLength = mean(QueueLength);
MaximumQueueLength = max(QueueLength);

disp(' ');
disp('QUEUE LENGTH TABLE');

fprintf('ID   Arrival   QueueLength\n');

for i = 1:N

    fprintf('%2d %8d %10d\n',...
        SortedID(i),...
        SortedArrival(i),...
        QueueLength(i));

end

%% ==========================================
% STEP 10 : FINAL REPORT
%% ==========================================

disp(' ');
disp('============================');
disp('PERFORMANCE METRICS');
disp('============================');

fprintf('Patients Served        : %d\n',PatientsServed);
fprintf('Average Waiting Time   : %.2f\n',AverageWaitingTime);
fprintf('Average System Time    : %.2f\n',AverageSystemTime);
fprintf('Average Queue Length   : %.2f\n',AverageQueueLength);
fprintf('Maximum Queue Length   : %d\n',MaximumQueueLength);
fprintf('Average Service Time   : %.2f\n',AverageServiceTime);
fprintf('Average InterArrival   : %.2f\n',AverageInterArrival);
fprintf('Probability Wait       : %.2f %%\n',ProbabilityWait);
fprintf('Makespan               : %.2f\n',Makespan);
fprintf('Overall Utilization    : %.2f %%\n',OverallUtilization);