function result = runSimulation(numDoctors,...
                                simulationTime,...
                                meanArrival,...
                                meanService,...
                                N)

arrival = generateArrival(N,meanArrival);
service = generateService(N,meanService);
priority = assignPriority(N);

doctorFree = zeros(1,numDoctors);
busyTime = zeros(1,numDoctors);

waiting = zeros(1,N);
startService = zeros(1,N);
finish = zeros(1,N);

for i=1:N

    [freeTime,doctor] = min(doctorFree);

    if arrival(i) >= freeTime

        startService(i)=arrival(i);

    else

        startService(i)=freeTime;

    end

    waiting(i)=startService(i)-arrival(i);

    finish(i)=startService(i)+service(i);

    doctorFree(doctor)=finish(i);

    actualService = service(i);

    if finish(i) > simulationTime
        actualService = simulationTime - startService(i);

        if actualService < 0
            actualService = 0;
        end
    end

    busyTime(doctor)=...
    busyTime(doctor)+actualService;

end

result = calculateMetrics(waiting,...
                          finish,...
                          busyTime,...
                          priority,...
                          arrival,...
                          service,...
                          simulationTime,...
                          numDoctors);

end