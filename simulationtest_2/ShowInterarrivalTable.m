function ShowInterarrivalTable()

while true

                    disp('Interarrival Table');
                    disp(' ')
                    disp('Interarrival Time Table');
                    disp('=================================');
                    disp('INTERARRIVAL TIME TABLE');
                    disp('=================================');
                    disp(' ')
                    disp('1. Peak Hour ')
                    disp('2. Non-Peak Hour ')
                    disp('3. Back ')
                    disp(' ')

                    interchoice = input('Select an option:  ');

                    switch interchoice

                        case 1
                                disp(' ');
                                disp('PEAK HOUR INTERARRIVAL TABLE');
                                disp('-------------------------------------------------------------');
                                disp('| Inter-Arrival Time (Min)  | 0     | 1     | 2     | 3     |');
                                disp('| Probability               |0.15   |0.35   |0.30   |0.20   |');
                                disp('| CDF                       |0.15   |0.50   |0.80   |1.00   |');
                                disp('| Range (RN)                |00-14  |15-49  |50-79  |80-99  |');
                                disp('-------------------------------------------------------------');
                        case 2
                                disp(' ');
                                disp('NON-PEAK HOUR INTERARRIVAL TABLE');
                                disp('-------------------------------------------------------------');
                                disp('| Inter-Arrival Time (Min)  | 2     | 3     | 4     | 5     |');
                                disp('| Probability               |0.20   |0.30   |0.30   |0.20   |');
                                disp('| CDF                       |0.20   |0.50   |0.80   |1.00   |');
                                disp('| Range (RN)                |00-19  |20-49  |50-79  |80-99  |');
                                disp('-------------------------------------------------------------');

                        case 3
                            break;

                        otherwise
                            disp('Invalid choice..')

                        end
                end