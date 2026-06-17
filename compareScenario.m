function compareScenario(a,b)

disp(' ');
disp('========== COMPARISON ==========');

fprintf('\nAverage Waiting Time\n');
fprintf('3 Doctors : %.2f\n',a.avgWaiting);
fprintf('4 Doctors : %.2f\n',b.avgWaiting);

fprintf('\nAverage Queue Length\n');
fprintf('3 Doctors : %.2f\n',a.avgQueue);
fprintf('4 Doctors : %.2f\n',b.avgQueue);

fprintf('\nDoctor Utilization\n');
fprintf('3 Doctors : %.2f%%\n',a.utilization*100);
fprintf('4 Doctors : %.2f%%\n',b.utilization*100);

fprintf('\nPatients Served\n');
fprintf('3 Doctors : %d\n',a.totalServed);
fprintf('4 Doctors : %d\n',b.totalServed);

disp(' ');
disp('===============================');