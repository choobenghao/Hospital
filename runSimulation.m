function result = runSimulation(numDoctors,...
                                simulationTime,...
                                meanArrival,...
                                meanService,...
                                N)

arrival = generateArrival(N,meanArrival);
service = generateService(N,meanService);
priority = assignPriority(N);

waiting = zeros(1,N);
startService = zeros(1,N);
finish = zeros(1,N);

doctorFinish = zeros(1,numDoctors);
busyTime = zeros(1,numDoctors);

served = zeros(1,N);

CriticalQueue = [];
UrgentQueue = [];
NormalQueue = [];

currentPatient = 1;

while currentPatient <= N

    t = arrival(currentPatient);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 把已经完成服务的病人处理掉
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    for d = 1:numDoctors

        while doctorFinish(d) <= t && ...
              (~isempty(CriticalQueue) || ...
               ~isempty(UrgentQueue) || ...
               ~isempty(NormalQueue))

            if ~isempty(CriticalQueue)

                p = CriticalQueue(1);
                CriticalQueue(1)=[];

            elseif ~isempty(UrgentQueue)

                p = UrgentQueue(1);
                UrgentQueue(1)=[];

            else

                p = NormalQueue(1);
                NormalQueue(1)=[];

            end

            startService(p)=doctorFinish(d);

            waiting(p)=...
                startService(p)-arrival(p);

            finish(p)=...
                startService(p)+service(p);

            doctorFinish(d)=finish(p);

            busyTime(d)=...
                busyTime(d)+service(p);

            served(p)=1;

        end

    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 新病人到达
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    [earliestTime,doctor]=min(doctorFinish);

    if t >= earliestTime

        startService(currentPatient)=t;

        finish(currentPatient)=...
            t+service(currentPatient);

        doctorFinish(doctor)=...
            finish(currentPatient);

        busyTime(doctor)=...
            busyTime(doctor)+...
            service(currentPatient);

        served(currentPatient)=1;

    else

        if priority(currentPatient)==1

            CriticalQueue=[CriticalQueue currentPatient];

        elseif priority(currentPatient)==2

            UrgentQueue=[UrgentQueue currentPatient];

        else

            NormalQueue=[NormalQueue currentPatient];

        end

    end

    currentPatient = currentPatient + 1;

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 模拟结束后继续处理队列
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

while ~isempty(CriticalQueue) || ...
      ~isempty(UrgentQueue) || ...
      ~isempty(NormalQueue)

    [earliestTime,doctor]=min(doctorFinish);

    if ~isempty(CriticalQueue)

        p=CriticalQueue(1);
        CriticalQueue(1)=[];

    elseif ~isempty(UrgentQueue)

        p=UrgentQueue(1);
        UrgentQueue(1)=[];

    else

        p=NormalQueue(1);
        NormalQueue(1)=[];

    end

    startService(p)=earliestTime;

    waiting(p)=...
        startService(p)-arrival(p);

    finish(p)=...
        startService(p)+service(p);

    doctorFinish(doctor)=finish(p);

    busyTime(doctor)=...
        busyTime(doctor)+service(p);

    served(p)=1;

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate Metrics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

result.avgWaiting = mean(waiting);

result.totalServed = ...
    sum(finish<=simulationTime);

result.utilization = ...
sum(busyTime)/(numDoctors*simulationTime);

result.avgQueue = ...
    sum(waiting>0)/N;

result.waiting = waiting;
result.finish = finish;
result.priority = priority;
result.arrival = arrival;

end