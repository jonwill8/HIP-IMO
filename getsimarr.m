%this function returns an array of values that simulate PAN administrations
%NOTE: A PAN administration is simulated by concatenating subarrays that range [0-->last hour of rest before next PAN dose]  
% cycle end = the day the cycle is over
function [simarr] = getsimarr(treatmentdays,cyclend,cyclenum)
%this function rakes in an array of treatment days, and then returns an
%array of values to be simulated for all cycles
simarr = zeros(1,1);

index = length(treatmentdays);
treatmentdays(index+1) = cyclend+1; %inputting last day of cycle for arr bulding purpose +1 so diff works

treatgaps = diff(treatmentdays); %check to make sure worked
%creating minigap arrays
%manually build first to avoid 0 issue

tarr = 0:1/12:treatgaps(1)*23;
%filling in simarr with first miniarr avoid 0 issue
for i = 1:1:length(tarr)
    simarr(i) = tarr(i);
end

for i = 2:1:length(treatgaps)
    backi = treatgaps(i)*23; %converting day gap into hours
    marr = 1/12:1/12:backi;
    simarr = horzcat(simarr,marr);
end
%1 cycle values done (stored in simarr)

Tsimarr = simarr;
Tsimarr(1) = [];
%4 cycle periods CHANGE IS SIMULATING MORE CYCLES
if cyclenum == 2
    simarr = horzcat(simarr,Tsimarr);
elseif cyclenum == 3
    simarr = horzcat(simarr,Tsimarr,Tsimarr);
elseif cyclenum == 4
    simarr = horzcat(simarr,Tsimarr,Tsimarr,Tsimarr);
elseif cyclenum == 5
    simarr = horzcat(simarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr);
elseif cyclenum == 6
    simarr = horzcat(simarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr);
elseif cyclenum == 7
    simarr = horzcat(simarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr);
elseif cyclenum == 8
    simarr = horzcat(simarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr);
elseif cyclenum == 9
    simarr = horzcat(simarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr);
elseif cyclenum == 10
    simarr = horzcat(simarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr);
elseif cyclenum == 11
    simarr = horzcat(simarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr);
elseif cyclenum == 12
    simarr = horzcat(simarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr);
elseif cyclenum == 13
    simarr = horzcat(simarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr);
elseif cyclenum == 14
    simarr = horzcat(simarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr);
elseif cyclenum == 15
    simarr = horzcat(simarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr,Tsimarr);
end
end

