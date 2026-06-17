function runSimulation(custAmount,peakchoice,numGenChoice,numDoctors)

N = custAmount;

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

        case 1
            RN_IA(i) = floor(rand()*100);

        otherwise
            RN_IA(i) = randi([0 99]);

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


end