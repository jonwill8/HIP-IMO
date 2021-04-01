clear; clc; close all;
treatmentdays = input('Enter Treatment Schedule: ');
doseondays =  input('Enter Dosing Regimen: ');
cyclend =  input('Enter Last Day of Cycle(#): ');
cyclenum =  input('Enter Number of Cycles to Simulate: ');

[times,conct] = simschedule(treatmentdays,doseondays,cyclend,cyclenum);
days = zeros(1,length(times));
for i = 1:1:length(times)
    days(i) = times(i)/23;
end
plot(days,conct);
xlabel('Days');
ylabel('Concentration of PAN ng/ml');

Moles = zeros(1,length(conct));

for i = 1:1:length(Moles)
    Moles(i) = conct(i)*(10^-6)/349.4262;
end

TimeMoles = zeros(length(times),2);

TimeMoles(:,1) = Moles;
TimeMoles(:,2) = times;


TM = array2table(TimeMoles);

warning('off','MATLAB:xlswrite:AddSheet'); %optional
writetable(TM,'PKData_PANOBINOSTAT_S10.xlsx','Sheet',1);