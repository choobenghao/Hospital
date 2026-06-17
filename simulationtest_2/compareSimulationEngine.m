function [AverageWaitingTime,...
          AverageSystemTime,...
          ProbabilityWait,...
          Makespan,...
          OverallUtilization] = ...
compareSimulationEngine(...
Arrival,...
RN_Type,...
PatientType,...
Priority,...
RN_Service,...
ServiceTime,...
numDoctors)

N = length(Arrival);


%% ==========================
% PRIORITY QUEUE
%% ==========================

QueueTable = zeros(N,4);

for i=1:N

    QueueTable(i,1)=i;
    QueueTable(i,2)=Priority(i);
    QueueTable(i,3)=Arrival(i);
    QueueTable(i,4)=ServiceTime(i);

end

for i=1:N-1

    for j=i+1:N

        swap=0;

        if QueueTable(j,2) > QueueTable(i,2)

            swap=1;

        elseif QueueTable(j,2)==QueueTable(i,2)

            if QueueTable(j,3) < QueueTable(i,3)

                swap=1;

            end

        end

        if swap==1

            temp=QueueTable(i,:);

            QueueTable(i,:)=QueueTable(j,:);
            QueueTable(j,:)=temp;

        end

    end

end

SortedID = QueueTable(:,1);

SortedArrival = zeros(N,1);
SortedPriority = zeros(N,1);
SortedService = zeros(N,1);

for i=1:N

    id = SortedID(i);

    SortedArrival(i)=Arrival(id);
    SortedPriority(i)=Priority(id);
    SortedService(i)=ServiceTime(id);

end

%% ==========================
% DOCTOR SCHEDULING
%% ==========================

DoctorFinishTime = zeros(1,numDoctors);
DoctorBusyTime = zeros(1,numDoctors);

WaitingTime = zeros(N,1);
SystemTime = zeros(N,1);

for i=1:N

    [EarliestTime,doc] = min(DoctorFinishTime);

    StartTime = max(SortedArrival(i),EarliestTime);

    EndTime = StartTime + SortedService(i);

    WaitingTime(i)=StartTime-SortedArrival(i);

    SystemTime(i)=EndTime-SortedArrival(i);

    DoctorFinishTime(doc)=EndTime;

    DoctorBusyTime(doc)= ...
    DoctorBusyTime(doc)+SortedService(i);

end

%% ==========================
% METRICS
%% ==========================

AverageWaitingTime = mean(WaitingTime);

AverageSystemTime = mean(SystemTime);

ProbabilityWait = ...
(sum(WaitingTime>0)/N)*100;

Makespan = max(DoctorFinishTime);

OverallUtilization = ...
(sum(DoctorBusyTime)/...
(Makespan*numDoctors))*100;

end