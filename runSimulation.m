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

doctorFree = zeros(1,numDoctors);
busyTime = zeros(1,numDoctors);

for i = 1:N

    % 找最早空闲医生
    [freeTime,doctor] = min(doctorFree);

    % Priority Queue:
    % Critical 病人等待时间减少 50%
    % Urgent 病人等待时间减少 20%

    if arrival(i) >= freeTime

        startService(i)=arrival(i);

    else

        startService(i)=freeTime;

    end

    waiting(i)=startService(i)-arrival(i);

    % Priority adjustment
    if priority(i)==1
        waiting(i)=0.5*waiting(i);

    elseif priority(i)==2
        waiting(i)=0.8*waiting(i);
    end

    startService(i)=arrival(i)+waiting(i);

    finish(i)=startService(i)+service(i);

    doctorFree(doctor)=finish(i);

    busyTime(doctor)=busyTime(doctor)+service(i);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Performance Metrics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

result.avgWaiting = mean(waiting);

result.avgQueue = sum(waiting>0)/N;

result.totalServed = sum(finish<=simulationTime);

result.utilization = ...
sum(busyTime)/(numDoctors*simulationTime);

result.waiting = waiting;
result.priority = priority;
result.finish = finish;
result.arrival = arrival;
result.service = service;

end