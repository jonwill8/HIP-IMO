%treatmentdays = day #s on which PAN is being administered
%doseondays = the respective dose of PAN patient will recieve on td
%cycleend = last day of cycle
%this function returns an array containing the respective concentrations of PAN in pateint
%over the entire treatment period
function [times,conct] = simschedule(treatmentdays,doseondays,cyclend,cyclenum)
%this function takes in a dose schedule an returns arr of days & concts

%Optimized transfer constants:
Ka = 0.3822;
K12 = 7.6239;
K21 = 1.6299;
Ke = 8.7500;

times = 0:1/12:(cyclenum*cyclend*23); %incrementing by 5 mins to end of treatment period
conct = zeros(1,length(times)); %same size as ^
%creating arr in which each elment corresponds to a single dose for every
%dosage that occurs in treatment period all 4 cycles
doseondaysfull = fixdosearr(doseondays,cyclenum);

%Note: Will Recalc c(t) at different doses to simuate varying doses on certain days
sym ct;
simarrvals = getsimarr(treatmentdays,cyclend,cyclenum);
ct = adjustc(doseondaysfull(1));
%manually inputting first 2 indexes
conct(1) = ct(simarrvals(1));
conct(2) = ct(simarrvals(2));

index = 2;
for i = 3:1:length(simarrvals)
    if simarrvals(i) == 1/12  
        ct = adjustc(doseondaysfull(index)); %conc-time funct of new dose
        conct(i) = ct(simarrvals(i));
        index = index + 1;
    else
        conct(i) = ct(simarrvals(i));
    end
end

for i = 1:1:length(conct)
    if isnan(conct(i))
        conct(i) = 0;
    end
end
end