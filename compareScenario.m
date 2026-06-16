function compareScenario(a,b)

fprintf('\n');
fprintf('Average Waiting Time\n');
fprintf('Scenario1 : %.2f\n',a.avgWaiting);
fprintf('Scenario2 : %.2f\n',b.avgWaiting);

fprintf('\n');
fprintf('Average Queue Length\n');
fprintf('Scenario1 : %.2f\n',a.avgQueue);
fprintf('Scenario2 : %.2f\n',b.avgQueue);

fprintf('\n');
fprintf('Doctor Utilization\n');
fprintf('Scenario1 : %.2f%%\n',...
        a.utilization*100);
fprintf('Scenario2 : %.2f%%\n',...
        b.utilization*100);

fprintf('\n');
fprintf('Patients Served\n');
fprintf('Scenario1 : %d\n',...
        a.totalServed);
fprintf('Scenario2 : %d\n',...
        b.totalServed);

end