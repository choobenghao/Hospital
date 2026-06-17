% ==========================
% STEP 10 : CASE ID + SAVE RESULT
% ==========================

CaseID = datestr(now,'yyyymmdd_HHMMSS');

CaseID = sprintf('CASE%d', CaseNumber);

FileName = strcat(CaseID,'.txt');

fid = fopen(FileName,'w');

fprintf(fid,'=====================================\n');
fprintf(fid,'HOSPITAL EMERGENCY SIMULATION\n');
fprintf(fid,'=====================================\n\n');

fprintf(fid,'Case ID : %s\n',CaseID);

fprintf(fid,'Patients Served : %d\n',PatientsServed);

fprintf(fid,'Average Waiting Time : %.2f\n', ...
        AverageWaitingTime);

fprintf(fid,'Average Queue Length : %.2f\n', ...
        AverageQueueLength);

fprintf(fid,'Average Service Time : %.2f\n', ...
        AverageServiceTime);

fprintf(fid,'Average Interarrival Time : %.2f\n', ...
        AverageInterArrival);

fprintf(fid,'Probability Wait : %.2f %%\n', ...
        ProbabilityWait);

fprintf(fid,'Makespan : %.2f\n', ...
        Makespan);

fprintf(fid,'Overall Utilization : %.2f %%\n', ...
        OverallUtilization);

fprintf(fid,'\n');
fprintf(fid,'DOCTOR UTILIZATION\n');

for d = 1:numDoctors

    fprintf(fid,...
    'Doctor %d : %.2f %%\n',...
    d,...
    DoctorUtilization(d));

end

fprintf(fid,'\n');

fprintf(fid,...
'ID Arr Type Pri Doc Start End Wait Sys\n');

for i = 1:N

fprintf(fid,...
'%d %d %s %d %d %d %d %d %d\n',...
i,...
ArrivalTime(i),...
PatientType{i},...
Priority(i),...
DoctorAssigned(i),...
StartTime(i),...
EndTime(i),...
WaitingTime(i),...
SystemTime(i));

end

fclose(fid);

disp(' ');
disp('Simulation Result Saved');

fprintf('File Name : %s\n',FileName);